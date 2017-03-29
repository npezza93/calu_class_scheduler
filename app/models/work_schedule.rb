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
#  day               :string
#  start_time        :time
#  end_time          :time
#

class WorkSchedule < ApplicationRecord
  # include TimeOverlaps

  belongs_to :user
  belongs_to :work_days_time
  belongs_to :semester

  # validate do
    # errors.add(:base, "You have a course scheduled for that time") if
      # overlaps_any?(user.offering_day_times)
  # end

  scope :with_start_time, lambda { |sel|
    select { |day_time| day_time.parsed_start_time == sel }
  }
  scope :for_semester, ->(semester) { where(semester: semester) }

  def prettier_day_time
    day + parsed_start_time
  end

  def parsed_start_time
    start_time.strftime("%l:%M%P").strip
  end

  def short_time
    day + start_time.strftime("%l%M%p").strip
  end

  def day_of_week
    { m: 0, t: 1, w: 2, r: 3, f: 4 }[day.downcase.to_sym]
  end

  def meeting_time?
    true
  end

  def end_time
    (start_time + 30.minutes) - 1.second
  end

  def time_range
    start_time..end_time
  end
end
