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

  def overlaps?(record)
    return false unless meeting_time?

    if record.is_a?(WorkSchedule)
      overlaps_work_schedule?(record)
    elsif record.is_a?(Offering)
      overlaps_offering?(record)
    end
  end

  def overlaps_any?(collection)
    collection.any? do |day_time|
      overlaps? day_time
    end
  end

  private

  def overlaps_work_schedule?(work_schedule)
    days.split("").include?(work_schedule.day) &&
      overlapping_time_range?(work_schedule.time_range)
  end

  def overlaps_offering?(offering)
    return false unless offering.meeting_time?

    days =~ Regexp.new(offering.days_time.regex_days) &&
      overlapping_time_range?(offering.time_range)
  end

  def overlapping_time_range?(other_time_range)
    time_range.overlaps?(other_time_range) || time_range == other_time_range
  end
end
