class CurriculumCategoriesController < ApplicationController
  before_action :set_category, only: [:destroy]
  before_action :set_user
  before_filter :authorize
  
  def index
    @category = CurriculumCategory.where(major_id: @user.major)
    @new_category = CurriculumCategory.new
  end

  def create
    @category = CurriculumCategory.new(category_params)
    
    respond_to do |format|
      if @category.save
       	format.js { render :js => "window.location.href='"+curriculum_categories_path+"'"}
        format.html { redirect_to curriculum_categories_path, notice: @category.category + " has been created!" }
      else
        format.js { @errors = true}
        format.html { render :new }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to curriculum_categories_url, notice: @category.category + " has been deleted!" }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = CurriculumCategory.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:curriculum_category).permit(:category, :required_amount_of_credits, :major_id)
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
