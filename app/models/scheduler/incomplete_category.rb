module Scheduler::IncompleteCategory
  def incomplete_category(category)
    incomplete_or_category(category) if category.or_sets?

    incomplete[category] =
      prerequisite_check(incomplete[category].values.flatten)
    used_courses.merge(incomplete[category])
    incomplete[category].flatten!

    add_incomplete_to_db(category)
  end

  def prerequisite_check(courses)
    courses.collect do |course|
      course.can_take(self, transcripts, taken_courses)
    end.flatten.compact
  end

  def add_incomplete_to_db(category)

    user_category = user_categories.where(
      curriculum_category_id: category.id, completed: false
    ).first_or_create

    incomplete[category].each do |course|
      next unless course.is_a? Course

      math_classes.push [course, category] if math_class?(course)
      user_category.user_category_courses.where(
        course_id: course.id, completed: false
      ).first_or_create
    end
    add_completed_courses_from_incomplete_category(category, user_category)
  end

  def add_completed_courses_from_incomplete_category(category, user_category)
    complete[category].values.flatten.each do |course|
      user_category.user_category_courses.where(
        course_id: course.id, completed: true
      ).first_or_create
    end
  end
end
