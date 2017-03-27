# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  def submit_to_advisor(approval)
    set_users_schedules(approval)

    mail to: @user.advisor_prof.email,
         subject: "Schedule Submitted for Your Approval"
  end

  def student_confirmation(approval)
    set_users_schedules(approval)

    mail to: @user.email, subject: "Schedule Submitted for Approval"
  end

  def advisor_confirmation(approval)
    set_users_schedules(approval)

    mail to: @user.advisor_prof.email, subject: "Schedule Approval Confirmation"
  end

  def approved(approval)
    set_users_schedules(approval)

    mail to: @user.email, subject: "Your Schedule Has Been Approved!"
  end

  private

  def set_users_schedules(approval)
    @approval = approval
    @user = approval.user
    @schedules = @user.courses
  end
end
