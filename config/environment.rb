# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.smtp_settings = {
    :enable_starttls_auto => true,
    :address => 'smtp.gmail.com',
    :port => 587,
    :domain => 'https://calu-advisor.herokuapp.com/',
    :authentication => :plain,
    :user_name => 'beautiful.soup.notification',
    :password => 'CalU011293!!15'
}