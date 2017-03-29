# frozen_string_literal: true

class CoursesController < ApplicationController
  load_and_authorize_resource :course, through_association: {
    prerequisite_groups: { prerequisites: :course }
  }

  def index
    respond_to do |format|
      format.html do
        @courses = Course.subject_by_letter(params[:letter]).group_by(&:subject)
      end
      format.json do
        render json: course_catalog_hash
      end
    end
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
      redirect_to @course, notice: "Course was successfully created!"
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

  def course_params
    params.require(:course).permit(
      :subject, :course, :title, :credits, :minimum_class_standing,
      :description, :minimum_sat_score, :minimum_pt,
      prerequisite_groups_attributes: [:id, :_destroy, course_ids: []]
    )
  end

  def course_catalog_hash
    @course_catalog_hash ||= {
      courses: Course.autocomplete_fields,
      subjects: Course.select(:subject).distinct
    }
  end
end
