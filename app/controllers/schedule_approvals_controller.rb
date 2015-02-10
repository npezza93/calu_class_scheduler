class ScheduleApprovalsController < ApplicationController
  before_action :set_user
  before_action :set_approval, only: [:update]
  before_action :set_active_semester
  
  def create
    @approval = ScheduleApproval.new(user: @user)
    
    if @approval.save
      respond_to do |format|
        flash[:notice] = 'Schedule successfully submitted for approval' 
        format.js {}
        format.html { redirect_to user_schedules_path(@user) }
      end
    end
  end

  def update
    if User.find(session[:user_id]).advisor
      if @approval.update(approved: "true")
        respond_to do |format|
          format.js {}
          format.html { redirect_to user_schedules_path(@user) }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to user_schedules_path(@user), notice: 'You must be an advisor' }
      end
    end
  end
  
  private
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_active_semester
      @active_semester= Semester.where(active: true).take
    end
    
    def set_approval
      @approval = ScheduleApproval.find(params[:id])
    end
end
