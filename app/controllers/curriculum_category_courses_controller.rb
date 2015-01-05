class CurriculumCategoryCoursesController < ApplicationController
  before_action :set_category, only: [:create, :index]
  before_action :set_category_course, only: [:index]

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
  end
  
  private
    def set_category
      @category = CurriculumCategory.find(params[:curriculum_category_id])
    end
    
    def set_category_course
      @category_course = CurriculumCategoryCourse.new
    end
    
    def curriculum_category_course_params
      params.require(:curriculum_category_course).permit(:course_id)
    end  
end