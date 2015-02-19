class WorkSchedulesController < ApplicationController
  before_action :set_user
  before_action :set_active_semester
  
  def index
    @work_schedules = WorkSchedule.where(user: @user, semester: @active_semester)
  end

  def create
    inserts = []
    WorkSchedule.delete_all(user: @user)
    if (params[:work_schedule][:work_days_time_id]).count > 1
      ((params[:work_schedule][:work_days_time_id]).reject! { |c| c.empty? }).each do |id|
        inserts.push "(" + @user.id.to_s+ ", " + id.to_s + "," + @active_semester.id.to_s + ")"
      end
      sql = "INSERT INTO work_schedules (`user_id`, `work_days_time_id`, `semester_id`) VALUES #{inserts.join(", ")}"
      (ActiveRecord::Base.connection).execute sql
    end
    
    @work_schedules = WorkSchedule.where(user: @user, semester: @active_semester)
    respond_to do |format|
      format.js   {}
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
