# frozen_string_literal: true

module WorkSchedules
  class Destroy < Base
    def perform
      show_schedule_offerings if work_schedule.destroy
    end

    def schedule_offerings
      @schedule_offerings ||= user.schedule_offerings.where(
        schedule_categories: { semester_id: semester_id }
      ).hidden
    end

    private

    def show_schedule_offerings
      schedule_offerings.select do |schedule_offering|
        offering = schedule_offering.offering

        schedule_offering.update(hidden: false) if offering_overlap?(offering)
      end
    end
  end
end
