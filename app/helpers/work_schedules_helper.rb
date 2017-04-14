# frozen_string_literal: true

module WorkSchedulesHelper
  def calendar_time_range
    year = [2000, 1, 1]
    Time.new(*year, 8, 0, 0, 0).to_i..Time.new(*year, 22, 0, 0, 0).to_i
  end

  def find_overlapping_work_schedule(work_schedules, day, start_time)
    work_schedules = work_schedules[day]

    return if work_schedules.blank?

    work_schedules.find do |work_schedule|
      work_schedule.start_time.to_i == start_time
    end
  end

  def find_overlapping_offering(offerings, day, start_time)
    offerings.find do |offering|
      work_schedule =
        WorkSchedule.new(day: day, start_time: Time.at(start_time).utc)
      offering.overlaps?(work_schedule)
    end
  end

  def work_schedule_id(weekday, start_time)
    start_time = Time.at(start_time).utc
    "#{weekday}_#{start_time.hour}_#{start_time.min}"
  end

  def calendar_day_header_data(day, params)
    col_day = params[:active_day] || "M"

    { data: { day: day, active: col_day == day } }
  end

  def calendar_time_slot_data(day, params, **opts)
    col_day = params[:active_day] || "M"

    { data: { day: day, active: col_day == day }.merge(opts) }
  end

  def calendar_day_header(day, prev_day, next_day)
    prev_link = day_toggle_link(prev_day, "chevron_left") if prev_day.present?
    next_link = day_toggle_link(next_day, "chevron_right") if next_day.present?

    prev_link.to_s.html_safe + content_tag(:div, day, class: "flex") +
      next_link.to_s.html_safe
  end

  private

  def day_toggle_link(active_day, chevron)
    link_to(work_schedules_path(active_day: active_day)) do
      material_icon.send(chevron).to_s
    end
  end
end
