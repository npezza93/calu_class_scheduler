# frozen_string_literal: true

module Schedules
  class Destroy < Base
    def perform
      return false unless schedule.destroy

      Schedules::CategoryOffering.transaction do
        show_schedules_offerings
      end
    end

    def show_schedules_offerings
      categories.each { |category| evaluate_category(category) }

      schedules_offerings.hidden.select do |schedule_offering|
        next if keep_hidden?(schedule_offering)

        modified << schedule_offering.offering_id
        schedule_offering.update(hidden: false)
      end
    end

    def work_schedules
      @work_schedules ||= user.work_schedules
    end

    def keep_hidden?(schedule_offering)
      return true if schedule_offering.offering.overlaps_any?(work_schedules)

      keep_hidden_state?(schedule_offering) &&
        user.course_ids.include?(schedule_offering.offering.course_id) &&
        @to_hide.exclude?(schedule_offering)
    end
  end
end
