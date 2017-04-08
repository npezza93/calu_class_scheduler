# frozen_string_literal: true

module Schedules
  class Destroy < Base
    def perform
      show_schedules_offerings if schedule.destroy
    end

    def show_schedules_offerings
      schedules_offerings.hidden.select do |schedule_offering|
        next unless schedule_offering.offering.overlaps?(schedule.offering)

        modified << schedule_offering.offering_id
        schedule_offering.update(hidden: false)
      end
    end
  end
end
