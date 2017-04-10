# frozen_string_literal: true

module Scheduler
  module CategorySetEvaluation
    def evaluate_category(category)
      complete[category] = {}
      incomplete[category] = {}

      if category.complete?((sets = category_sets(category)))
        complete_category(category, sets.index(true))
      else
        incomplete_category(category, user.schedules_categories.where(
          curriculum_category_id: category.id,
          completed: false, semester: semester
        ).first_or_create)
      end
    end

    # Gather the completion of sets
    def category_sets(category)
      category.curriculum_category_sets.map do |category_set|
        complete[category][category_set] = category_set.courses & taken_courses

        get_incomplete_from_set(category, category_set)
      end
    end

    def get_incomplete_from_set(category, category_set)
      # check if only a couple courses from a set are needed for completion
      if category_set.count.present?
        eval_completion_of_set_with_count(category, category_set)
      # else all courses in a set are needed for it to be completed
      else
        all =
          complete[category][category_set].count == category_set.courses.count
        add_incomplete_from_set(category, category_set) unless all

        all
      end
    end

    def eval_completion_of_set_with_count(category, category_set)
      required_numbered_of_courses = category_set.count

      if complete[category][category_set].count < required_numbered_of_courses
        add_incomplete_from_set(category, category_set)
      end

      complete[category][category_set].count >= required_numbered_of_courses
    end

    def add_incomplete_from_set(category, category_set)
      incomplete[category][category_set] = category_set.courses - taken_courses
    end

    # Deal with a complete category
    def complete_category(category, set_index)
      incomplete.delete(category)
      cat_sets = category.curriculum_category_sets

      # if only one set is needed to complete category, returns
      # the first complete set instead of all of them
      complete[category] = (
        if category.or_sets?
          cat_sets[set_index].courses
        else
          cat_sets.flat_map(&:courses)
        end & taken_courses).uniq

      add_completed_to_db(complete[category], category: category)
    end
  end
end
