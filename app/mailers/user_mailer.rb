class UserMailer < ActionMailer::Base
  default from: 'no-reply@calu.edu'

  def submit_for_advising(user)
    @user = user
    @schedules = @user.schedules
    mail to: advisor_email(@user), subject: 'Schedule Submitted for Approval'
  end

  def approval_submission_confirmation(user)
    @user = user
    @schedules = @user.schedules
    mail to: @user.email, subject: 'Schedule Submitted Confirmation'
  end

  def approval_confirmation(user)
    @user = user
    @schedules = @user.schedules
    mail to: advisor_email(@user), subject: 'Schedule Approval Confirmation'
  end

  def approved(user)
    @user = user
    @schedules = @user.schedules
    mail to: @user.email, subject: 'Your Schedule Has Been Approved!'
  end

  private

  def advisor_email(user)
    User.find(user.advised_by).email
  end
end
