# frozen_string_literal: true
class ScheduleApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_approval, only: [:update]
  authorize_resource

  def create
    if current_user.credits >= 12
      @approval = ScheduleApproval.create(
        user: current_user, semester: active_semester
      )

      flash[:notice] = "Schedule successfully submitted for approval"
    else
      flash[:notice] = "You need to sign up for  12 or more credits"
    end
    redirect_to work_schedules_path
  end

  def update
    @approval.approve

    redirect_to users_path, notice: "Approved #{@approval.user.name}'s schedule"
  end

  private

  def set_approval
    @approval = ScheduleApproval.find(params[:id])
  end
end
