# frozen_string_literal: true

module Schedules
  class Base
    include Scheduler::CategorySetEvaluation
    include Scheduler::IncompleteCategory

    attr_accessor :schedule, :user, :semester_id, :modified, :complete,
                  :incomplete, :to_hide
    delegate :new_record?, :destroyed?, to: :schedule
    delegate :transcripts, to: :user

    def initialize(schedule, user, semester_id)
      @schedule    = schedule
      @user        = user
      @semester_id = semester_id
      @modified    = []
      @complete    = {}
      @incomplete  = {}
      @to_hide     = []
    end

    def schedules_offerings
      @schedules_offerings ||= user.schedules_offerings.where(
        schedules_categories: { semester_id: semester_id }
      ).includes(:category, offering: %i(days_time course)).where.not(
        offering_id: schedule.offering_id
      ).where.not(offering_id: scheduled_offerings)
    end

    def keep_hidden_state?(schedule_offering)
      !schedule_offering.offering.overlaps?(schedule.offering) &&
        can_add_course?(schedule_offering) &&
        schedule_offering.offering.course_id != schedule.offering.course_id
    end

    def total_credits
      @total_credits ||= schedules.flat_map(&:course).sum(&:credits)
    end

    def scheduled_offerings
      @scheduled_offerings ||= schedules.flat_map(&:offering_id)
    end

    def can_add_course?(schedule_offering)
      (total_credits + schedule_offering.course.credits) <= 18
    end

    def taken_courses
      @taken_courses ||= user.taken_courses + schedules.flat_map(&:course)
    end

    def categories
      @categories ||=
        user.plain_categories_for_courses(schedule.course.id).includes(
          curriculum_category_sets: :courses
        )
    end

    def schedules
      @schedules ||=
        user.schedules.includes(offering: :course).for_semester(semester_id)
    end

    def evaluate_category(category)
      complete[category] = {}
      incomplete[category] = {}

      if category.complete?(category_sets(category))
        add_complete_to_hide(category)
      else
        incomplete_or_category(category) if category.or_sets?
        add_incomplete_to_hide(category, incomplete[category].values.flatten)
      end
    end

    def add_incomplete_to_hide(category, courses)
      @to_hide += schedules_offerings.select do |schedules_offering|
        schedules_offering.category.curriculum_category_id == category.id &&
        courses.exclude?(schedules_offering.course)
      end
    end

    def add_complete_to_hide(category)
      @to_hide += schedules_offerings.select do |schedules_offering|
        schedules_offering.category.curriculum_category_id == category.id
      end
    end
  end
end
