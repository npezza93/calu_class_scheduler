class ScheduleApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_approval, only: [:update]

  def create
    @approval = ScheduleApproval.new(user: @user)

    if @approval.save
      @user.send_for_approval
      @user.send_approval_submission_confirmation
      respond_to do |format|
        flash[:notice] = 'Schedule successfully submitted for approval'
        format.js {}
        format.html { redirect_to user_schedules_path(@user) }
      end
    end
  end

  def update
    if User.find(session[:user_id]).advisor
      if @approval.update(approved: 'true')
        @user.send_approved_confirmation
        @user.send_approved
        redirect_to user_schedules_path(@user)
      end
    else
      redirect_to user_schedules_path(@user), notice: 'You must be an advisor'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_approval
    @approval = ScheduleApproval.find(params[:id])
  end
end
