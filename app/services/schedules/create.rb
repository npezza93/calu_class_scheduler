# frozen_string_literal: true

module Schedules
  class Create < Base
    def perform
      hide_schedules_offerings if schedule.save
    end

    def schedules_offerings
      @schedules_offerings ||= user.schedules_offerings.where(
        schedules_categories: { semester_id: semester_id }
      ).visible.includes(offering: :days_time)
    end

    def hide_schedules_offerings
      schedules_offerings.select do |schedule_offering|
        next unless hide?(schedule_offering.offering)

        modified << schedule_offering.offering_id
        schedule_offering.update(hidden: true)
      end
    end

    def hide?(offering)
      offering.id != schedule.offering_id &&
        offering.overlaps?(schedule.days_time)
    end

    def saved?
      !new_record?
    end
  end
end
