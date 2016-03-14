class DaysTime < ActiveRecord::Base
  validates_uniqueness_of :days, scope: [:start_time, :end_time]

  def pretty_day_time
    if days == 'ONLINE' || days == 'OFFSITE'
      days
    else
      days + ' at ' + start_time + ' to ' + end_time
    end
  end

  def meeting_time?
    !start_time.nil? && !end_time.nil?
  end

  def regex_days
    days.split('').join('|')
  end

  def start_time_as_time
    Time.parse(start_time)
  end

  def end_time_as_time
    Time.parse(end_time)
  end

  def time_range
    start_time_as_time..end_time_as_time
  end

  def range_overlap?(compare_range)
    time_range.begin <= compare_range.end &&
      compare_range.begin <= time_range.end
  end

  def overlaps?(days_time)
    return false unless meeting_time? || days_time.meeting_time?

    days =~ Regexp.new(days_time.regex_days) && range_overlap?(days_time)
  end

  def overlaps_any?(collection)
    collection.each do |day_time|
      return true if overlaps? day_time
    end
  end
end
