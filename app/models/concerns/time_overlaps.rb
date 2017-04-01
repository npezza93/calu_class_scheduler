# frozen_string_literal: true

module TimeOverlaps
  def regex_days
    days.split("").join("|")
  end

  def time_range
    start_time..end_time
  end

  def range_overlap?(compare_range)
    time_range.begin <= compare_range.end &&
      compare_range.begin <= time_range.end
  end

  def overlaps?(days_time)
    return false unless meeting_time?

    days =~ Regexp.new(days_time.regex_days) &&
      range_overlap?(days_time.time_range)
  end

  def overlaps_any?(collection)
    collection.each do |day_time|
      return true if overlaps? day_time
    end
    false
  end
end
