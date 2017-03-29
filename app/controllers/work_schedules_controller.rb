# frozen_string_literal: true

class WorkSchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work_schedule, only: :destroy
  authorize_resource

  def index
    set_work_schedules_offerings
  end

  def create
    @work_schedule = current_work_schedules.create(work_schedule_params)
    set_work_schedules_offerings

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @work_schedule.destroy
    set_work_schedules_offerings

    respond_to do |format|
      format.js
    end
  end

  private

  def set_work_schedule
    @work_schedule = WorkSchedule.find(params[:id])
  end

  def current_work_schedules
    @current_work_schedules ||=
      current_user.work_schedules.for_semester(current_semester)
  end

  def set_work_schedules_offerings
    @work_schedules ||= current_work_schedules.group_by(&:day)
    @offerings ||= current_user.offerings.for_semester(current_semester)
                               .has_meeting_time.includes(:days_time).load
  end

  def work_schedule_params
    { day: params[:day], start_time: Time.at(params[:start_time].to_i).utc }
  end
end
