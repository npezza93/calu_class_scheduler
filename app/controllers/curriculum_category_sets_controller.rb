class CurriculumCategorySetsController < ApplicationController
  before_action :set_category, only: [:create, :index, :edit, :update]
  before_action :set_category_set, only: [:destroy, :edit, :update]
  
  before_filter :authorize

  def create
    @category_set = @category.curriculum_category_sets.new(count: params[:count])
    
    respond_to do |format|
      if @category_set.save
        params[:course_id].each do |course_id|
          @category_set.course_set.create(course_id: course_id)
        end 
        format.html { redirect_to curriculum_category_curriculum_category_sets_path, notice: "Courses for " + @category.category + " submitted" }
      else
        format.html { render :index }
      end
    end
  end

  def index
    @courses = Course.all.order(:course).map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }
    @cc_courses = @category.curriculum_category_sets.group_by(&:id).flatten.flatten
    @cc_courses = Hash[*@cc_courses]
  end
  
  def destroy
    @curriculum_category_set.course_set.destroy_all
    @curriculum_category_set.destroy
    respond_to do |format|
      format.html { redirect_to curriculum_category_curriculum_category_sets_path, notice: "Set removed!" }
      format.js {}
    end
  end
  
  def edit
    @courses = Course.all.order(:course).map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }
    @set_courses = @curriculum_category_set.course_set.map { |set| set.course.id }
  end

  def update
    @curriculum_category_set.update(curriculum_category_course_params)
    @curriculum_category_set.course_set.destroy_all
    
    params[:course_id].each do |course_id|
      @curriculum_category_set.course_set.create(course_id: course_id)
    end 
    
    respond_to do |format|
      format.html { redirect_to curriculum_category_curriculum_category_sets_path, notice: "Set edited!" }
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