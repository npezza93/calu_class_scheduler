class WorkSchedulesController < ApplicationController
  before_action :set_user
  before_action :set_active_semester
  
  def index
    @work_schedules = WorkSchedule.where(user: @user, semester: @active_semester)
  end

  def create
    WorkSchedule.delete_all(user: @user)
    ((params[:work_schedule][:work_days_time_id]).reject! { |c| c.empty? }).each do |id|
      WorkSchedule.create(user: @user, work_days_time_id: id)
    end
    respond_to do |format|
      format.html { redirect_to user_schedules_path(@user) }
      format.js   {@schedules, @common_courses, @new_category_courses, @remaining_credits  = view_context.sched_algorithm(@user.id)}
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_schedule_params
      params.require(:work_schedule).permit(:user_id, :work_schedule => [:work_days_time_id])
    end
    
    def set_active_semester
      @active_semester = Semester.where(active: true).take
    end
end
