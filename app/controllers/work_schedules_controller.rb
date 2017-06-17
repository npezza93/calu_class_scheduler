# frozen_string_literal: true

class WorkSchedulesController < ApplicationController
  load_and_authorize_resource

  def index
    @work_schedules = current_work_schedules.group_by(&:day)
    @offerings = current_user.offerings.for_semester(
      current_semester_id
    ).includes(:days_time).load
    @online_courses = @offerings.reject(&:meeting_time?)
    @offerings = @offerings.select(&:meeting_time?)
  end

  def create
    work_schedule = current_work_schedules.new(work_schedule_params)
    @service = WorkSchedules::Create.new(
      work_schedule, current_user, current_semester_id
    )

    @service.perform

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @service = WorkSchedules::Destroy.new(
      @work_schedule, current_user, current_semester_id
    )

    @service.perform

    respond_to do |format|
      format.js
    end
  end

  private

  def current_work_schedules
    @current_work_schedules ||=
      current_user.work_schedules.for_semester(current_semester_id)
  end

  def work_schedule_params
    { day: params[:day], start_time: Time.at(params[:start_time].to_i).utc }
  end
end
