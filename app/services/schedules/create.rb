# frozen_string_literal: true

module Schedules
  class Create < Base
    def perform
      hide_schedules_offerings if schedule.save
    end

    def hide_schedules_offerings
      schedules_offerings.visible.select do |schedule_offering|
        next unless schedule_offering.offering.overlaps?(schedule.offering)

        modified << schedule_offering.offering_id
        schedule_offering.update(hidden: true)
      end
    end

    def saved?
      !new_record?
    end
  end
end
