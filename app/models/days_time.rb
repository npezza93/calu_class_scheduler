# frozen_string_literal: true

# == Schema Information
#
# Table name: days_times
#
#  id         :integer          not null, primary key
#  days       :string(255)
#  start_time :string(255)
#  end_time   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class DaysTime < ApplicationRecord
  include TimeOverlaps

  validates_uniqueness_of :days, scope: %i(start_time end_time)

  scope :has_meeting_time, -> { where.not(start_time: nil, end_time: nil) }

  def pretty_day_time
    if days == "ONLINE" || days == "OFFSITE"
      days
    else
      days + " at " + start_time + " to " + end_time
    end
  end

  def meeting_time?
    start_time.present? && end_time.present?
  end
end
