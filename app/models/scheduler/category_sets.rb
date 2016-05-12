module Scheduler::InitializeCategory
  def category_sets(category)
    sets = []

    category.curriculum_category_sets.each do |category_set|
      sets << eval_category_set(category, category_set)
    end

    sets
  end

  def eval_category_set(category, category_set)
    complete[category][category_set] = category_set.courses & taken_courses

    get_incomplete_from_set(category, category_set, category_set.count)
  end

  def get_incomplete_from_set(category, category_set, count)
    if !count.blank?
      eval_count_of_set(category, category_set, count)
    else
      all = complete[category][category_set] == count
      add_incomplete_from_set(category, category_set) unless all

      all
    end
  end

  def eval_count_of_set(category, category_set, count)
    if complete[category][category_set].count < count
      add_incomplete_from_set(category, category_set)
    end

    complete[category][category_set].count >= count
  end

  def add_incomplete_from_set(category, category_set)
    incomplete[category][category_set] = category_set.courses - taken_courses
  end
end
