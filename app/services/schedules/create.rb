# frozen_string_literal: true

module Schedules
  class Create < Base
    def perform
      return false unless schedule.save

      hide_schedules_offerings
    end

    def hide_schedules_offerings
      categories.each { |category| evaluate_category(category) }

      modified = schedules_offerings.select do |schedule_offering|
        next if schedule_offering.hidden? || keep_visible?(schedule_offering)

        schedule_offering
      end

      Schedules::CategoryOffering.where(id: modified.map(&:id)).update_all(
        hidden: true
      )
      @modified = modified.map(&:offering_id)
    end

    def saved?
      !new_record?
    end

    def keep_visible?(schedule_offering)
      visible = keep_hidden_state?(schedule_offering) &&
        schedules.map(&:course).map(&:id).exclude?(
          schedule_offering.offering.course_id
        )

      visible_offerings = @to_hide[schedule_offering.curriculum_category]

      if visible_offerings.present?
        visible &&= visible_offerings.exclude?(schedule_offering)
      end

      visible
    end
  end
end
