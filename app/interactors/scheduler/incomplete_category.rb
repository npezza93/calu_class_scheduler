# frozen_string_literal: true

class Scheduler
  module IncompleteCategory
    def incomplete_category(category, user_category)
      incomplete_or_category(category) if category.or_sets?

      incomplete[category] = prerequisite_check(category).flatten
      used_courses.merge(incomplete[category])

      add_incomplete_to_db(category)
      add_completed_courses_from_incomplete_category(category, user_category)
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

    def add_incomplete_to_db(category)
      user_category = user.schedule_categories.where(
        curriculum_category_id: category.id, completed: false
      ).first_or_create

      incomplete[category].each do |course|
        next unless course.is_a? Course

        capture_math_class(course, category)
        user_category.user_category_courses.where(
          course_id: course.id, completed: false
        ).first_or_create
      end
    end

    def capture_math_class(course, category)
      return unless math_class?(course)

      math_classes << [course, category]
    end

    def add_completed_courses_from_incomplete_category(category, user_category)
      complete[category].values.flatten.each do |course|
        user_category.user_category_courses.where(
          course_id: course.id, completed: true
        ).first_or_create
      end
    end
  end
end
