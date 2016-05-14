class WorkSchedulesController < ApplicationController
  before_action :set_work_schedule, only: :destroy
  authorize_resource

  def index
    @work_schedule = WorkSchedule.new
    @work_schedules = current_user.work_schedules.to_a
    @work_times = current_user.work_days_times.to_a

    @work_time_slots = WorkDaysTime.all.sort_by do |date_time|
      [date_time.start_time, date_time.day_of_week]
    end
  end

  def create
    days = create_schedules_hash

    current_user.work_schedules.create(days) if days

    respond_to do |format|
      format.html { redirect_to work_schedules_path }
      format.js { render layout: false }
    end
  end

  def destroy
    @work_schedule.destroy

    respond_to do |format|
      format.html { redirect_to work_schedules_path }
      format.js { render layout: false }
    end
  end

  private

  def create_schedules_hash
    if (type = params[:type])
      map_type(type) if type == 'day' || type == 'time'
    else
      {
        work_days_time_id: params[:work_days_time_id], semester: active_semester
      }
    end
  end

  def map_type(type)
    if type == 'day'
      ws = current_work_schedules(WorkDaysTime.where(days: params[:day].upcase))
      count = 27
      ids = WorkDaysTime.where(days: params[:day]).pluck(:id)
    else
      ws = current_work_schedules(WorkDaysTime.with_start_time(params[:time]))
      count = 5
      ids = WorkDaysTime.with_start_time(params[:time]).pluck(:id)
    end

    make_hash(ws, count, ids)
  end

  def make_hash(work_days_time, count, ids)
    if work_days_time.count != count
      ids.map do |id|
        { work_days_time_id: id, semester: active_semester }
      end
    else
      work_days_time.delete_all
      nil
    end
  end

  def current_work_schedules(scope)
    current_user.work_schedules.where(
      work_days_time: scope, semester: active_semester
    )
  end

  def set_work_schedule
    @work_schedule = WorkSchedule.find(params[:id])
  end
end
