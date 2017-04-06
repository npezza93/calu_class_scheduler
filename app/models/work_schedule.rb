# frozen_string_literal: true

# == Schema Information
#
# Table name: work_schedules
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  semester_id :integer
#  day         :string
#  start_time  :time
#

class WorkSchedule < ApplicationRecord
  include SemesterHelpers

  belongs_to :user

  validates :start_time, uniqueness: { scope: %i(user_id semester_id day) }

  def end_time
    (start_time + 30.minutes) - 1.second
  end

  def time_range
    start_time.to_i..end_time.to_i
  end

  def time_id
    "#{day}_#{start_time.hour}_#{start_time.min}"
  end

  def path_id
    { day: day, start_time: start_time.to_i }
  end
end
