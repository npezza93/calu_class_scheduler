module Scheduler
  include Scheduler::CategorySets
  include Scheduler::CompleteCategory
  include Scheduler::IncompleteCategory
  include Scheduler::IncompleteOrCategory
  include Scheduler::Instances
  include Scheduler::MathClasses

  def scheduler
    categories.each do |category|
      complete[category] = {}
      incomplete[category] = {}
      eval_category(category)
    end

    # add_needed_math_classes
  end

  def eval_category(category)
    sets = category_sets(category)

    if category.complete?(sets)
      complete_category(category, sets.index(true))
    else
      incomplete_category(category)
    end
  end
end
