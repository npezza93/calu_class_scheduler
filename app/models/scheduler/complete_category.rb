module Scheduler::CompleteCategory
  def complete_category(category, set_index)
    incomplete.delete(category)

    # if only one set is needed to complete category, returns
    # the first complete set instead of all of them
    complete[category] =
      if category.or_sets?
        category.curriculum_category_sets[set_index].courses & taken_courses
      else
        category.courses & taken_courses
      end.uniq
    add_completed_to_db(category)
  end

  def add_completed_to_db(category)
    user_category = user_categories.where(
      curriculum_category_id: category.id, completed: true
    ).first_or_create

    complete[category].each do |course|
      user_category.user_category_courses.where(
        course_id: course.id, completed: true
      ).first_or_create
    end
  end
end
