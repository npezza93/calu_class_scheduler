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
  belongs_to :semester

  scope :for_semester, ->(semester) { where(semester: semester) }

  def end_time
    (start_time + 30.minutes) - 1.second
  end

  def time_range
    start_time..end_time
  end
end
