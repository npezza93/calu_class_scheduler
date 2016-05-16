class SchedulerJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.user_categories.destroy_all
    user.scheduler
  end
end
