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

    def offering_overlap?(offering, scheduled_offering)
      offering.overlaps?(scheduled_offering.days_time)
    end
  end
end
