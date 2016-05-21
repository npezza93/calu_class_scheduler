module Scheduler::IncompleteOrCategory
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
end
