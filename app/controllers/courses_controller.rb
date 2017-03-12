# frozen_string_literal: true
class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:destroy, :edit, :update, :show]
  authorize_resource

  def index
    @courses = Course.subject_by_letter(params[:letter]).group_by(&:subject)
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: "Course was successfully created!"
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @course.destroy

    redirect_to courses_url, notice: "Course was successfully destroyed."
  end

  private

  def set_course
    @course = Course.includes(
      prerequisite_groups: { prerequisites: :course }
    ).find(params[:id])
  end

  def course_params
    params.require(:course).permit(
      :subject, :course, :title, :credits, :minimum_class_standing,
      :minimum_sat_score, :minimum_pt, prerequisites: []
    )
  end
end
