# frozen_string_literal: true

module Transcripts
  class Destroy < Base
    def perform
      return false unless transcript.destroy

      schedules_categories.destroy_all
      scheduler.perform
      hide_schedules_category_offerings
    end
  end
end
