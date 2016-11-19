class DaysTime < ApplicationRecord
  include TimeOverlaps

  validates_uniqueness_of :days, scope: [:start_time, :end_time]

  def pretty_day_time
    if days == "ONLINE" || days == "OFFSITE"
      days
    else
      days + " at " + start_time + " to " + end_time
    end
  end

  def meeting_time?
    !start_time.blank? && !end_time.blank?
  end
end
