# frozen_string_literal: true

module Schedules
  class Base
    attr_accessor :schedule, :user, :semester_id
    delegate :new_record?, :destroyed?, to: :schedule

    def initialize(schedule, user, semester_id)
      @schedule    = schedule
      @user        = user
      @semester_id = semester_id
    end
  end
end
