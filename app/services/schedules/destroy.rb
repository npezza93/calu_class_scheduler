# frozen_string_literal: true

module Schedules
  class Destroy < Base
    def perform
      show_schedules_offerings if schedule.destroy
    end

    def schedules_offerings
      @schedules_offerings ||= user.schedules_offerings.where(
        schedules_categories: { semester_id: semester_id }
      ).hidden.includes(offering: :days_time).where.not(
        offering_id: schedule.offering_id
      )
    end

    def show_schedules_offerings
      schedules_offerings.select do |schedule_offering|
        schedule_offering.offering.overlaps?(schedule.days_time)

        modified << schedule_offering.offering_id
        schedule_offering.update(hidden: false)
      end
    end

    def saved?
      !new_record?
    end
  end
end
