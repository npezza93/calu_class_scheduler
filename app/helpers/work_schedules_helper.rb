# frozen_string_literal: true

module WorkSchedulesHelper
  def work_schedule_time_range
    year = [2000, 1, 1]
    Time.new(*year, 8, 0, 0, 0).to_i..Time.new(*year, 22, 0, 0, 0).to_i
  end

  def find_overlapping_work_schedule(work_schedules, day, start_time)
    work_schedules = work_schedules[day]

    return if work_schedules.blank?

    work_schedules.find do |work_schedule|
      work_schedule.start_time == Time.at(start_time).utc
    end
  end

  def find_overlapping_offering(offerings, day, start_time)
    offerings = offerings.select do |offering|
      offering.days_time.meeting_time? &&
        offering.days_time.days.split("").include?(day)
    end

    return if offerings.blank?

    offerings.find do |offering|
      offering.days_time.range_overlap?(work_schedule_range(start_time))
    end
  end

  def work_schedule_id(weekday, start_time)
    start_time = Time.at(start_time).utc
    "#{weekday}_#{start_time.hour}_#{start_time.min}"
  end

  def work_schedule_range(start_time)
    WorkSchedule.new(start_time: Time.at(start_time).utc).time_range
  end
end
