class CurriculumCategorySetsController < ApplicationController
  before_action :set_category, except: :destroy
  before_action :set_category_set, only: [:destroy, :edit, :update, :show]
  
  before_filter :authorize

  def new
    @curriculum_category_set = CurriculumCategorySet.new
  end

  def create
    @category_set = @category.curriculum_category_sets.new(curriculum_category_course_params)
    
    respond_to do |format|
      if @category_set.save
        format.html { redirect_to curriculum_category_curriculum_category_sets_path, notice: "Set for " + @category.category + " created!" }
      else
        format.html { render :index }
      end
    end
  end

  def index
    @category_sets = @category.curriculum_category_sets
  end
  
  def destroy
    @curriculum_category_set.course_set.destroy_all
    @curriculum_category_set.destroy
    respond_to do |format|
      format.html { redirect_to curriculum_category_curriculum_category_sets_path, notice: "Set removed!" }
      format.js {}
    end
  end

  def show
  end

  def edit
  end

  def update
    @curriculum_category_set.update(curriculum_category_course_params)

    respond_to do |format|
      format.html { redirect_to curriculum_category_curriculum_category_sets_path, notice: "Set for " + @category.category + " updated!" }
      format.js {}
    end        
  end
  
  private
    def set_category
      @category = CurriculumCategory.find(params[:curriculum_category_id])
    end
    
    def set_category_set
      @curriculum_category_set = CurriculumCategorySet.find(params[:id])
    end
    
    def curriculum_category_course_params
      params.require(:curriculum_category_set).permit(:count)
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end