class CourseSetsController < ApplicationController
  before_action :set_category
  before_action :set_category_set
  before_action :set_course_set, only: :destroy

  before_filter :authorize

  def new
    @course_set = CourseSet.new
  end

  def create
    @course_set = CourseSet.new(course_set_params)
    @course_set.curriculum_category_set = @category_set
    respond_to do |format|
      if @course_set.save
       	flash[:notice] = @course_set.course.pretty_course + " has been added to the set!"
       	format.js { render :js => "window.location.href='"+curriculum_category_curriculum_category_set_path(@category,@category_set)+"'"}
        format.html { redirect_to curriculum_category_curriculum_category_set_path(@category,@category_set), notice: @course_set.course.pretty_course + " has been added to the set!" }
      else
        format.html { render :new }
        format.js {}
      end
    end
  end

  def destroy
    # @course_set.destroy
    respond_to do |format|
      format.html { redirect_to curriculum_category_curriculum_category_set_path(@category,@category_set), notice: "Course removed from set!" }
      format.js {}
    end
  end

  private
    def set_category
      @category = CurriculumCategory.find(params[:curriculum_category_id])
    end
    
    def set_category_set
      @category_set = CurriculumCategorySet.find(params[:curriculum_category_set_id])
    end

    def set_course_set
      @course_set = CourseSet.find(params[:id])
    end

    def course_set_params
      params.require(:course_set).permit(:course_id)
    end
    
    def authorize
      logged_in = User.find_by_id(session[:user_id])
      if not (logged_in.advisor or logged_in.administrator)
        redirect_to user_transcripts_path(logged_in), notice: "You're not authorized to view this page!"
      end
    end
end