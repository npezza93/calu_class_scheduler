# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@calu.edu"
  layout "mailer"
end
