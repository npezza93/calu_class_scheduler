class WorkSchedulesController < ApplicationController
  before_action :set_user
  before_action :set_active_semester
  before_action :set_work_schedule, only: :destroy
  
  def index
    @work_schedules = WorkSchedule.where(user: @user, semester: @active_semester)
  end

  def create
    @work_schedule = WorkSchedule.new(work_schedule_params)
    @work_schedule.user = @user
    respond_to do |format|
      if @work_schedule.save
        format.js {}
      end
    end
  end

  def destroy
    @work_schedule.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_schedule_params
      params.require(:work_schedule).permit(:work_days_time_id)
    end
    
    def set_active_semester
      @active_semester = Semester.where(active: true).take
    end

    def set_work_schedule
      @work_schedule = WorkSchedule.find(params[:id])
    end
end
