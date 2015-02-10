class CurriculumCategoryCoursesController < ApplicationController
  before_action :set_category, only: [:create, :index]
  before_action :set_category_course, only: [:destroy]
  
  before_filter :authorize

  def create
    @category_course = @category.curriculum_category_courses.create(curriculum_category_course_params)
    @category_course.curriculum_category_id= @category.id
    
    respond_to do |format|
      if @category_course.save
        format.html { redirect_to curriculum_category_curriculum_category_courses_path, notice: "Course added to category" }
        format.js {}
      else
        format.html { render :index }
        format.js { @errors = true }
      end
    end
  end

  def index
    @new_category_course = CurriculumCategoryCourse.new
    @courses = (Course.all.order(:course).map { |course| [course.subject + course.course.to_s + ": " + course.title, course.id] }) << ["",-1]
    @cc_courses = @category.curriculum_category_courses.all
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
      params.require(:curriculum_category_course).permit(:course_id)
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end