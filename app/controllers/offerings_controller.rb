# frozen_string_literal: true

class OfferingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, except: :import
  before_action :set_offering, only: %i(destroy edit update)
  authorize_resource

  def index
    @offerings = @course.offerings.for_semester
  end

  def new
    @offering = @course.offerings.for_semester.new
  end

  def edit
  end

  def create
    @offering = @course.offerings.for_semester.new(offering_params)

    if @offering.save
      redirect_to course_offerings_path(@course),
                  notice: "Offering was successfully created!"
    else
      render :new
    end
  end

  def update
    if @offering.update(offering_params)
      redirect_to course_offerings_path, notice: "Offering updated!"
    else
      render :new
    end
  end

  def destroy
    @offering.destroy
    Schedule.where(offering: @offering).delete_all

    redirect_to course_offerings_path(@course),
                notice: "Offering was successfully deleted!"
  end

  def import
    Offering.import(params[:offering_file])

    redirect_to courses_path, notice: "Offerings Uploaded!"
  end

  private

  def set_offering
    @offering = @course.offerings.for_semester.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def offering_params
    params.require(:offering).permit(:days_time_id, :user_id, :section)
  end
end
