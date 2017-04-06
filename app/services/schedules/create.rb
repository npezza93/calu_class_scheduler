# frozen_string_literal: true

module Schedules
  class Create < Base
    def perform
      hide_schedules_offerings if schedule.save
    end

    def hide_schedules_offerings
    end
  end
end
