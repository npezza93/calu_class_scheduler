class CurriculumCategoriesController < ApplicationController
  before_action :set_category, only: [:destroy,:update, :edit]
  before_action :set_user
  before_action :set_major
  
  before_filter :authorize
  
  def index
    @major_categories = CurriculumCategory.where(major: @major, minor: false)
    @minor_categories = CurriculumCategory.where(major: @major, minor: true)
  end

  def new
    @category = CurriculumCategory.new
  end

  def edit
    @set_log_op = "na"
    if @category.set_and_or_flag == false 
      @set_log_op = "and"
    elsif @category.set_and_or_flag
      @set_log_op = "or"
    end
  end

  def create
    @category = CurriculumCategory.new(category_params)
    if category_params[:set_and_or_flag] == "0"
      @category.set_and_or_flag = nil
    end
    @category.major = @major
    respond_to do |format|
      if @category.save
        flash[:notice] = @category.category + " successfully created!"
        if params[:continue] == "1"
       	  format.js { render :js => "window.location.href='"+new_curriculum_category_curriculum_category_set_path(@category)+"'"}
        else
          format.js { render :js => "window.location.href='"+curriculum_categories_path+"'"}
        end
        format.html { redirect_to curriculum_categories_path, notice: @category.category + " has been created!" }
      else
        format.js { @errors = true}
        format.html { render :new }
      end
    end
  end

  def destroy
    @category.curriculum_category_sets.each do |set|
      set.course_set.destroy_all
    end
    @category.curriculum_category_sets.destroy_all
    @category.destroy
    respond_to do |format|
      format.html { redirect_to curriculum_categories_url, notice: @category.category + " successfully deleted!" }
      format.json { head :no_content }
    end
  end
  
  def update
    if @category.update(category_params)
      if category_params[:set_and_or_flag] == "0"
        @category.update(set_and_or_flag: nil)
      end
      respond_to do |format|
        flash[:notice] = @category.category + " successfully updated!"
        format.js { render :js => "window.location.href='"+curriculum_categories_path+"'"}
        format.html { redirect_to curriculum_categories_url, notice: @category.category + " successfully deleted!" }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.js {}
        format.html { redirect_to curriculum_categories_url, notice: @category.category + " successfully deleted!" }
        format.json { head :no_content }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = CurriculumCategory.find(params[:id])
    end
    
    def set_major
      @major = @user.major
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:curriculum_category).permit(:category, :minor, :set_and_or_flag)
    end
    
    def set_user
      @user = User.find(session[:user_id])
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end
