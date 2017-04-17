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

      modified = schedules_offerings.select do |schedule_offering|
        next if !schedule_offering.hidden? || keep_hidden?(schedule_offering)

        schedule_offering
      end

      Schedules::CategoryOffering.where(id: modified.map(&:id)).update_all(
        hidden: false
      )
      @modified = modified.map(&:offering_id)
    end

    def work_schedules
      @work_schedules ||= user.work_schedules
    end

    def keep_hidden?(schedule_offering)
      return true if schedule_offering.offering.overlaps_any?(work_schedules)
      return true if schedules.map(&:course).include?(
        schedule_offering.offering.course
      )

      hide = keep_hidden_state?(schedule_offering)
      if @to_hide.key?(schedule_offering.curriculum_category)
        hidden_offerings = @to_hide[schedule_offering.curriculum_category]
        hide &&= hidden_offerings.include?(schedule_offering)
      end

      hide
    end
  end
end
