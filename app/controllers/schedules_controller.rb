class SchedulesController < ApplicationController
  before_action :set_schedule, only: :destroy
  authorize_resource

  def index
    current_user.scheduler

    @work_schedules = current_user.work_schedules.includes(:work_days_time)
    @schedules = current_user.offerings
  end

  def create
    @schedule = current_user.schedules.create(
      offering_id: params[:offering_id],
      semester: @active_semester
    )

    respond_to do |format|
      format.html { redirect_to schedules_path }
      format.js
    end
  end

  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_path }
      format.js
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
end
