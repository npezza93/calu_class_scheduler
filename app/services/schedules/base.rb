# frozen_string_literal: true

module Schedules
  class Base
    attr_accessor :schedule, :user, :semester_id, :modified
    delegate :new_record?, :destroyed?, to: :schedule

    def initialize(schedule, user, semester_id)
      @schedule    = schedule
      @user        = user
      @semester_id = semester_id
      @modified    = []
    end

    def schedules_offerings
      @schedules_offerings ||= user.schedules_offerings.where(
        schedules_categories: { semester_id: semester_id }
      ).includes(offering: :days_time).where.not(
        offering_id: schedule.offering_id
      )
    end
  end
end
