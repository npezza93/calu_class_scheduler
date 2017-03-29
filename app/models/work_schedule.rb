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
  belongs_to :user
  belongs_to :work_days_time
  belongs_to :semester

  scope :with_start_time, lambda { |sel|
    select { |day_time| day_time.parsed_start_time == sel }
  }
  scope :for_semester, ->(semester) { where(semester: semester) }

  def parsed_start_time
    start_time.strftime("%l:%M%P").strip
  end

  def end_time
    (start_time + 30.minutes) - 1.second
  end

  def time_range
    start_time..end_time
  end
end
