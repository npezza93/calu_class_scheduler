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

  def covert_to_offerings(category)
    unless incomplete[category].empty?
      incomplete[category].select! do |course|
        math_classes.push [course, category] if math_class?(course)
        course.is_a? Course
      end
      incomplete[category].map!(&:offerings).flatten!
    end
  end

end
