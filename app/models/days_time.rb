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
  validates :days, uniqueness: { scope: %i(start_time end_time) }

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

  def time_range
    start_time.to_i..end_time.to_i
  end

  def regex_days
    days.split("").join("|")
  end

  def overlaps?(days_time)
    return false if !meeting_time? || !days_time.meeting_time?

    days =~ Regexp.new(days_time.regex_days) &&
      (time_range.overlaps?(days_time.time_range) ||
       time_range == days_time.time_range)
  end

  def overlaps_any?(collection)
    collection.any? do |day_time|
      overlaps? day_time
    end
  end
end
