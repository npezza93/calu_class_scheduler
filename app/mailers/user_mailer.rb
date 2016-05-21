class UserMailer < ActionMailer::Base
  def submit_to_advisor(approval)
    @approval = approval
    @user = approval.user
    @schedules = @user.courses
    mail to: @user.advisor_prof.email,
         subject: 'Schedule Submitted for Your Approval'
  end

  def student_confirmation(approval)
    @user = approval.user
    @schedules = @user.schedules
    mail to: @user.email, subject: 'Schedule Submitted for Approval'
  end

  def advisor_confirmation(approval)
    @user = approval.user
    @schedules = @user.schedules
    mail to: @user.advisor_prof.email, subject: 'Schedule Approval Confirmation'
  end

  def approved(approval)
    @user = approval.user
    @schedules = @user.schedules
    mail to: @user.email, subject: 'Your Schedule Has Been Approved!'
  end
end
