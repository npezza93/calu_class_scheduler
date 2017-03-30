# frozen_string_literal: true
# == Schema Information
#
# Table name: days_times
#
#  id         :integer          not null, primary key
#  days       :string(255)
#  start_time :datetime
#  end_time   :datetime
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
      days + " at " +
        start_time.strftime("%l:%M %P") + " to " + end_time.strftime("%l:%M %P")
    end
  end

  def meeting_time?
    start_time.present? && end_time.present?
  end
end
