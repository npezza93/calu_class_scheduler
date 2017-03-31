# frozen_string_literal: true

class Scheduler
  include IncompleteCategory
  include MathClasses

  attr_accessor :user, :complete, :incomplete, :math_classes, :used_courses,
                :semester
  delegate :categories, :taken_courses, :transcripts, to: :user

  def initialize(user:, semester:)
    @user            = user
    @complete        = {}
    @incomplete      = {}
    @math_classes    = []
    @used_courses    = Set.new
    @semester        = semester
  end

  def perform
    categories.each do |category|
      evaluate_category(category)
    end

    add_needed_math_classes
  end

  def evaluate_category(category)
    complete[category] = {}
    incomplete[category] = {}

    if category.complete?((sets = category_sets(category)))
      complete_category(category, sets.index(true))
    else
      incomplete_category(category, user.schedule_categories.where(
        curriculum_category_id: category.id,
        completed: false, semester: semester
      ).first_or_create)
    end
  end

  # Gather the completion of sets
  def category_sets(category)
    sets = []

    category.curriculum_category_sets.each do |category_set|
      complete[category][category_set] = category_set.courses & taken_courses

      sets << get_incomplete_from_set(category, category_set)
    end

    sets
  end

  def get_incomplete_from_set(category, category_set)
    # check if only a couple courses from a set are needed for completion
    if category_set.count.present?
      eval_completion_of_set_with_count(category, category_set)
    # else all courses in a set are needed for it to be completed
    else
      all = complete[category][category_set].count == category_set.courses.count
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

    # if only one set is needed to complete category, returns
    # the first complete set instead of all of them
    complete[category] = (
      if category.or_sets?
        category.curriculum_category_sets[set_index].courses
      else
        category.courses
      end & taken_courses).uniq

    add_completed_to_db(complete[category], category: category)
  end

  def add_completed_to_db(courses, category: nil, schedule_category: nil)
    schedule_category ||= user.schedule_categories.where(
      curriculum_category_id: category.id, completed: true, semester: semester
    ).first_or_create

    courses.each do |course|
      schedule_category.category_courses.where(
        course_id: course.id
      ).first_or_create
    end
  end

  def add_schedule_offering_from_course(schedule_category, course)
    course.offerings.for_semester(semester).each do |offering|
      schedule_category.category_offerings.where(
        offering_id: offering.id
      ).first_or_create
    end
  end
end
