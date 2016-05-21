class WorkSchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work_schedule, only: :destroy
  authorize_resource

  def index
    @offerings = current_user.offerings.includes(:days_time)
    @work_schedule = WorkSchedule.new
    @work_schedules = current_user.work_schedules.to_a
    @work_times = current_user.work_days_times.to_a

    @work_time_slots = WorkDaysTime.all.sort_by do |date_time|
      [date_time.start_time, date_time.day_of_week]
    end
  end

  def create
    time_slots = create_schedules_hash
    if time_slots
      ActiveRecord::Base.transaction do
        current_user.work_schedules.create(time_slots)
      end
    end

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
      send("map_#{type}")
    else
      {
        work_days_time_id: params[:work_days_time_id], semester: active_semester
      }
    end
  end

  def map_day
    ws = current_work_schedules(WorkDaysTime.where(days: params[:day].upcase))
    ids = WorkDaysTime.where(days: params[:day]).pluck(:id)
    make_hash(ws, ids)
  end

  def map_time
    ws = current_work_schedules(WorkDaysTime.with_start_time(params[:time]))
    ids = WorkDaysTime.with_start_time(params[:time]).pluck(:id)
    make_hash(ws, ids)
  end

  def make_hash(work_days_time, ids)
    if work_days_time.count == 0
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
