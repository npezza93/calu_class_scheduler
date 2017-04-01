# frozen_string_literal: true

class WorkSchedule
  class Create
    attr_accessor :new_work_schedules, :user, :semester

    def initialize(new_work_schedules, user, semeseter)
      @new_work_schedules = Array.wrap(new_work_schedules)
      @user           = user
      @semeseter      = semeseter
    end

    def perform
      new_work_schedules.each do |work_schedule|

      end
    end
  end
end
