class SchedulesController < ApplicationController
  before_action :set_schedule, only: :destroy
  # after_action :render_index, except: :index
  authorize_resource

  def index
    setup_index
  end

  def create
    current_user.schedules.create(
      offering_id: params[:offering_id],
      semester: active_semester
    )
    redirect_to schedules_path
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_path
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def setup_index
    current_user.scheduler

    @work_schedules = current_user.work_schedules.includes(:work_days_time)
    @schedules = current_user.offerings
  end
end
