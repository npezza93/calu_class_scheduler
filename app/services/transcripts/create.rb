# frozen_string_literal: true

class Transcripts
  class Create < Base
    def perform
      return false unless transcript.save

      schedules_categories.destroy_all
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

    def schedules_categories
      @schedules_categories ||= user.schedules_categories.where(
        curriculum_category: categories.map(&:id), semester_id: semester_id
      )
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
