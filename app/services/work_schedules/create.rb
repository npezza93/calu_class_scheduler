# frozen_string_literal: true

module WorkSchedules
  class Create < Base
    def perform
      return false if overlapping_offering.present?

      hide_schedules_offerings if work_schedule.save
    end

    def schedules_offerings
      @schedules_offerings ||= user.schedules_offerings.where(
        schedules_categories: { semester_id: semester_id }
      ).visible.includes(offering: :days_time)
    end

    def overlapping_offering
      @overlapping_offering ||= offerings.find do |offering|
        offering.days_time.meeting_time? &&
          offering.days_time.days.split("").include?(work_schedule.day) &&
          offering.days_time.range_overlap?(work_schedule.time_range)
      end
    end

    def saved?
      !new_record?
    end

    def hide_schedules_offerings
      schedules_offerings.select do |schedule_offering|
        offering = schedule_offering.offering

        schedule_offering.update(hidden: true) if offering_overlap?(offering)
      end
    end
  end
end
