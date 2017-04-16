# frozen_string_literal: true

class ScheduleApprovalsController < ApplicationController
  load_and_authorize_resource

  def create
    if current_user.credits(current_semester_id) >= 12
      @approval = ScheduleApproval.create(
        user: current_user, semester: current_semester
      )

      flash[:notice] = "Schedule successfully submitted for approval"
    else
      flash[:notice] = "You need to sign up for  12 or more credits"
    end
    redirect_to schedules_path
  end

  def update
    @schedule_approval.approve

    redirect_to users_path,
                notice: "Approved #{@schedule_approval.user.name}'s schedule"
  end
end
