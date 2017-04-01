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

  def end_time
    (start_time + 30.minutes) - 1.second
  end

  def time_range
    start_time..end_time
  end
end
