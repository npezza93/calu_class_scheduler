# frozen_string_literal: true
# == Schema Information
#
# Table name: work_schedules
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  work_days_time_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  semester_id       :integer
#

class WorkSchedule < ApplicationRecord
  belongs_to :user
  belongs_to :work_days_time
  belongs_to :semester

  validates_uniqueness_of :work_days_time, scope: :user
  validate do
    errors.add(:base, "You have a course scheduled for that time") if
      work_days_time.overlaps_any?(user.offering_day_times)
  end

  def pretty_day_time
    work_days_time.short_time
  end

  def prettier_day_time
    work_days_time.days + work_days_time.start_time.strftime("%l:%M%p").strip
  end
end
