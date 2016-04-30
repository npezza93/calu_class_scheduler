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
    current_user.work_schedules.create(
      work_days_time_id: params[:work_days_time_id],
      semester: @active_semester
    )

    redirect_to work_schedules_path
  end

  def create_day
    if current_day_work_schedules.count != 27
      WorkDaysTime.where(days: params[:day]).find_each do |day_time|
        crete_work_schedule(day_time)
      end
    else
      current_day_work_schedules.delete_all
    end

    redirect_to work_schedules_path
  end

  def create_time
    if current_time_work_schedules.count != 5
      WorkDaysTime.with_start_time(params[:time]).each do |day_time|
        crete_work_schedule(day_time)
      end
    else
      current_time_work_schedules.delete_all
    end

    redirect_to work_schedules_path
  end

  def destroy
    @work_schedule.destroy

    redirect_to work_schedules_path
  end

  private

  def current_day_work_schedules
    current_user.work_schedules.where(
      work_days_time: WorkDaysTime.where(days: params[:day].upcase),
      semester: @active_semester
    )
  end

  def current_time_work_schedules
    current_user.work_schedules.where(
      work_days_time: WorkDaysTime.with_start_time(params[:time]),
      semester: @active_semester
    )
  end

  def crete_work_schedule(day_time)
    current_user.work_schedules.create(
      work_days_time: day_time,
      semester: @active_semester
    )
  end

  def set_work_schedule
    @work_schedule = WorkSchedule.find(params[:id])
  end
end
