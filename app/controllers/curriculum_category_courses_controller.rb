class CurriculumCategoryCoursesController < ApplicationController
  before_action :set_category, only: [:create, :index]
  before_action :set_category_course, only: [:destroy]
  
  before_filter :authorize

  def create
    @category.curriculum_category_courses.destroy_all
    @course_groups = (curriculum_category_course_params[:course_id]).join("_").split("__").map{ |group| group.split("_").reject(&:empty?) }
    @course_groups.each do |group|
      group_id = @category.curriculum_category_courses.pluck(:course_group_id).max
      group_id = (group_id == nil) ? 1 : group_id + 1
      group.each do |group_course|
        @category.curriculum_category_courses.create(course_id: group_course, course_group_id: group_id)
      end
    end
    if params.has_key?(:logic_flag)
      @category.logic_flag = true
      @category.save
    else
      @category.logic_flag = false
      @category.save
    end
    
    respond_to do |format|
      format.html { redirect_to curriculum_category_curriculum_category_courses_path, notice: "Courses for " + @category.category + " submitted" }
    end
  end

  def index
    @new_category_course = CurriculumCategoryCourse.new
    @courses = Course.all.order(:course).map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }
    @cc_courses = @category.curriculum_category_courses.group_by(&:course_group_id)
    @max_group_id = @cc_courses.keys.max
    if @max_group_id == nil
      @max_group_id = 1
    end
  end
  
  def destroy
    @curriculum_category_course.destroy
    respond_to do |format|
      format.html { redirect_to curriculum_category_curriculum_category_courses_path, notice: @curriculum_category_course.course.title + " removed!" }
      format.js {}
    end
  end
  
  private
    def set_category
      @category = CurriculumCategory.find(params[:curriculum_category_id])
    end
    
    def set_category_course
      @curriculum_category_course = CurriculumCategoryCourse.find(params[:id])
    end
    
    def curriculum_category_course_params
      params.require(:curriculum_category_course).permit({:course_id => []})
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end