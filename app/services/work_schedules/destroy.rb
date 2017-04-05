# frozen_string_literal: true

module WorkSchedules
  class Destroy < Base
    def perform
      show_schedules_offerings if work_schedule.destroy
    end

    def schedules_offerings
      @schedules_offerings ||= user.schedules_offerings.where(
        schedules_categories: { semester_id: semester_id }
      ).hidden
    end

    private

    def show_schedules_offerings
      schedules_offerings.select do |schedule_offering|
        offering = schedule_offering.offering

        schedule_offering.update(hidden: false) if offering_overlap?(offering)
      end
    end
  end
end
