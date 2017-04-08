# frozen_string_literal: true

module WorkSchedules
  class Create < Base
    def perform
      return false if overlapping_scheduled_offering?

      hide_schedules_offerings if work_schedule.save
    end

    def saved?
      !new_record?
    end

    private

    def overlapping_scheduled_offering?
      user.offerings.for_semester(
        semester_id
      ).has_meeting_time.includes(:days_time).find do |offering|
        offering.overlaps?(work_schedule)
      end
    end

    def hide_schedules_offerings
      schedules_offerings.visible.each do |schedule_offering|
        schedule_offering.update(hidden: true) if
          schedule_offering.offering.overlaps?(work_schedule)
      end
    end
  end
end
