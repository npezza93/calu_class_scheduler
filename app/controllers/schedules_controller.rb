class SchedulesController < ApplicationController
  before_action :set_schedule, only: :destroy
  authorize_resource

  def index
    courses = current_user.scheduler
    @completed_category_courses = courses.first
    @incomplete_category_courses = courses.second

    @work_schedules = current_user.work_schedules.includes(:work_days_time)
    @schedules = current_user.offerings
    @offerings = @incomplete_category_courses.values.flatten.collect(&:id)
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.create(schedule_params)

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

  def schedule_params
    params.require(:schedule).permit(:offering_id)
          .merge(user: current_user, semester: @active_semester)
  end
end
