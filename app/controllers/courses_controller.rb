class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:destroy, :edit, :update]
  authorize_resource

  def index
    @courses = Course.search(params[:search])
  end

  def new
    @course = Course.new
    @prerequisite_groups = @course.prerequisite_groups.build
    @prerequisites = @course.prerequisites.build
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path,
                  notice: @course.title + ' was successfully created!'
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path,
                  notice: @course.subject + @course.course.to_s +
                          'successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy

    redirect_to courses_url,
                notice: @course.title + ' was successfully destroyed.'
  end

  private

  def set_course
    @course = Course.includes(prerequisite_groups: :prerequisites)
                    .find(params[:id])
  end

  def course_params
    params.require(:course).permit(
      :subject, :course, :title, :credits, :minimum_class_standing,
      :minimum_sat_score, :minimum_pt, prerequisites: []
    )
  end
end
