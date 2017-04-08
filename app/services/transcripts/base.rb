# frozen_string_literal: true

module Transcripts
  class Base
    attr_accessor :transcript, :user, :semester_id
    delegate :new_record?, :destroyed?, to: :transcript

    def initialize(transcript, user, semester_id)
      @transcript    = transcript
      @user          = user
      @semester_id   = semester_id
    end

    def hide_schedules_category_offerings
      schedules_category_offerings.each do |category_offering|
        category_offering.update(hidden: true) if
          category_offering.offering.overlaps_any?(work_schedules)
      end
    end

    def categories
      @categories ||=
        user.categories.where(courses: { id: transcript.course_id })
    end

    def schedules_categories
      @schedules_categories ||= user.schedules_categories.where(
        curriculum_category: categories.map(&:id), semester_id: semester_id
      ).includes(offerings: :days_time)
    end

    def schedules_category_offerings
      schedules_categories.reload.flat_map(&:category_offerings)
    end

    def scheduler
      @scheduler ||= Scheduler::Runner.new(
        user: user, semester: semester_id, categories: categories
      )
    end

    def work_schedules
      @work_schedules ||= user.work_schedules
    end
  end
end
