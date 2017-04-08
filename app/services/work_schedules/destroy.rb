# frozen_string_literal: true

module WorkSchedules
  class Destroy < Base
    def perform
      show_schedules_offerings if work_schedule.destroy
    end

    private

    def show_schedules_offerings
      schedules_offerings.hidden.each do |schedule_offering|
        schedule_offering.update(hidden: false) if
          schedule_offering.offering.overlaps?(work_schedule)
      end
    end
  end
end
