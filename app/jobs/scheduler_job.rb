class SchedulerJob < ApplicationJob
  queue_as :default

  def perform(user, course_id = nil)
    if course_id.present?
      categories = user.categories(course_id).pluck(:id)
      user.user_categories.where(curriculum_category_id: categories).destroy_all
    else
      user.user_categories.destroy_all
    end
    user.scheduler
  end
end
