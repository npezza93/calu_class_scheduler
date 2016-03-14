class WorkSchedulesController < ApplicationController
  before_action :set_work_schedule, only: :destroy
  authorize_resource

  def index
    @work_schedules = current_user.work_schedules.to_a

    @work_times = current_user.work_days_times.to_a

    @work_time_slots = WorkDaysTime.all.sort_by do |date_time|
      [date_time.start_time, date_time.day_of_week]
    end

    @work_schedule = WorkSchedule.new
  end

  def create
    unless current_user.advisor?
      current_user.work_schedules.create(work_schedule_params)
    end

    redirect_to work_schedules_path
  end

  def destroy
    @work_schedule.destroy unless current_user.advisor?

    redirect_to work_schedules_path
  end

  private

  def work_schedule_params
    params.require(:work_schedule).permit(:work_days_time_id)
          .merge(user: current_user, semester: Semester.active)
  end

  def set_work_schedule
    @work_schedule = WorkSchedule.find(params[:id])
  end
end
