# frozen_string_literal: true

module Transcripts
  class Destroy < Base
    def perform
      return false unless transcript.destroy

      schedules_categories.destroy_all
      scheduler.perform
      hide_schedules_category_offerings
    end

    def schedules_categories
      @schedules_categories ||= user.schedules_categories.where(
        curriculum_category: categories.map(&:id), semester_id: semester_id
      ).includes(offerings: :days_time)
    end

    def categories
      @categories ||=
        user.categories.where(courses: { id: transcript.course_id })
    end

    def scheduler
      @scheduler ||= Scheduler::Runner.new(
        user: user, semester: semester_id, categories: categories
      )
    end
  end
end
