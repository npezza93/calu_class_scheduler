# frozen_string_literal: true

class Scheduler
  module IncompleteCategory
    def incomplete_category(category, schedules_category)
      incomplete_or_category(category) if category.or_sets?

      used_courses.merge(
        (incomplete[category] = prerequisite_check(category).flatten)
      )

      add_incomplete_to_db(category, schedules_category)
      add_completed_to_db(
        complete[category].values.flatten,
        schedules_category: schedules_category
      )
    end

    # handle category with sets that are ored together
    def incomplete_or_category(category)
      reset_incomplete_category_courses(category)
      reset_complete_category_courses(category)

      temp_set = complete[category].keys.first
      temp_courses = complete[category].values.flatten.uniq
      complete[category] = {}
      complete[category][temp_set] = temp_courses
    end

    def reset_incomplete_category_courses(category)
      incomplete[category] = incomplete[category].select do |_, value|
        value.count == incomplete[category].values.map(&:count).min
      end
    end

    def reset_complete_category_courses(category)
      complete[category] = complete[category].select do |_, value|
        value.count == incomplete[category].values.map(&:count).max
      end
    end

    # returns courses that user is eligible to take
    def prerequisite_check(category)
      incomplete[category].values.flatten.collect do |course|
        course.can_take?(user, transcripts, taken_courses)
      end.flatten.compact
    end

    def add_incomplete_to_db(category, schedules_category)
      incomplete[category].each do |course|
        next unless course.is_a? Course

        capture_math_class(course, category)
        add_schedule_offering_from_course(schedules_category, course)
      end
    end
  end
end
