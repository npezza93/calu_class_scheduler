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

    def schedules_offerings
      @schedules_offerings ||= user.schedules_offerings.where(
        schedules_categories: { semester_id: semester_id }
      ).includes(offering: :days_time)
    end
  end
end
