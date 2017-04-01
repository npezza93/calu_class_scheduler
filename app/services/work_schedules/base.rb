# frozen_string_literal: true

module WorkSchedules
  class Base
    attr_accessor :work_schedule, :user, :semester_id
    delegate :new_record?, :destroyed?, to: :work_schedule

    def initialize(work_schedule, user, semester_id)
      @work_schedule = work_schedule
      @user          = user
      @semester_id   = semester_id
    end

    def work_schedules
      @work_schedules ||= user.work_schedules.for_semester(
        semester_id
      ).group_by(&:day)
    end

    def offerings
      @offerings ||= user.offerings.for_semester(
        semester_id
      ).has_meeting_time.includes(:days_time)
    end

    def offering_overlap?(offering)
      offering.days_time.meeting_time? &&
        offering.days_time.days.split("").include?(work_schedule.day) &&
        offering.days_time.range_overlap?(work_schedule.time_range)
    end
  end
end
