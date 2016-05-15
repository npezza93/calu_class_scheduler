module TimeOverlaps
  def regex_days
    days.split('').join('|')
  end

  def start_time_as_time
    if start_time.is_a? Time
      start_time
    else
      Time.parse("2000-01-01 #{start_time} utc")
    end
  end

  def end_time_as_time
    if end_time.is_a? Time
      end_time
    else
      Time.parse("2000-01-01 #{end_time} utc")
    end
  end

  def time_range
    start_time_as_time..end_time_as_time
  end

  def range_overlap?(compare_range)
    time_range.begin <= compare_range.time_range.end &&
      compare_range.time_range.begin <= time_range.end
  end

  def overlaps?(days_time)
    return false if !meeting_time? || !days_time.meeting_time?

    days =~ Regexp.new(days_time.regex_days) && range_overlap?(days_time)
  end

  def overlaps_any?(collection)
    collection.each do |day_time|
      return true if overlaps? day_time
    end
    false
  end
end
