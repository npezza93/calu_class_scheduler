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
  end
end
