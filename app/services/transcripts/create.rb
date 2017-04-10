# frozen_string_literal: true

module Transcripts
  class Create < Base
    def perform
      return false unless transcript.save

      Schedules::CategoryOffering.where(
        id: schedules_category_offerings
      ).delete_all

      scheduler.perform
      remove_schedules
      hide_schedules_category_offerings
      true
    end

    def remove_schedules
      user.schedules.joins(:offering).where(
        offerings: { course_id: transcript.course_id, semester_id: semester_id }
      ).destroy_all
    end
  end
end
