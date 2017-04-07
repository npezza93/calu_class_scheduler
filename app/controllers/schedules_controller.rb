# frozen_string_literal: true

class SchedulesController < ApplicationController
  authorize_resource

  def index
    schedules_categories = current_user.schedules_categories.for_semester(
      current_semester
    ).eager_load(
      :curriculum_category, :courses,
      category_offerings: [offering: %i(course days_time user)]
    )

    @completed_categories = schedules_categories.select(&:completed?)
    @incomplete_categories = schedules_categories.reject(&:completed?)
    @schedules = current_user.offerings.map(&:id)
  end

  def create
    schedule = current_user.schedules.new(
      offering_id: params[:offering_id], semester_id: current_semester_id
    )
    @service = Schedules::Create.new(
      schedule, current_user, current_semester_id
    )
    @service.perform

    respond_to do |format|
      format.js
    end
  end

  def destroy
    schedule = current_user.schedules.find_by(
      offering_id: params[:id], semester_id: current_semester_id
    )
    @service = Schedules::Destroy.new(
      schedule, current_user, current_semester_id
    )
    @service.perform

    respond_to do |format|
      format.js
    end
  end
end
