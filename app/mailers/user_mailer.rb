class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end
  
  def submit_for_advising(user)
    @user = user
    @schedules = @user.schedules
    mail to: (User.find(@user.advised_by)).email, subject: "Schedule Submitted for Approval"
  end
  
  def approval_submission_confirmation(user)
    @user = user
    @schedules = @user.schedules
    mail to: @user.email, subject: "Schedule Submitted Confirmation"
  end
  
  def approval_confirmation(user)
    @user = user
    @schedules = @user.schedules
    mail to: (User.find(@user.advised_by)).email, subject: "Schedule Approval Confirmation"
  end
  
  def approved(user)
    @user = user
    @schedules = @user.schedules
    mail to: @user.email, subject: "Your Schedule Has Been Approved!"
  end
end
