module Scheduler
  include Scheduler::CategorySets
  include Scheduler::CompleteCategory
  include Scheduler::IncompleteOrCategory
  include Scheduler::Instances
  include Scheduler::MathClasses

  def scheduler
    categories.each do |category|
      complete[category] = {}
      incomplete[category] = {}
      eval_category(category)
    end

    math_pt
  end

  def eval_category(category)
    sets = category_sets(category)

    if category.complete?(sets)
      complete_category(category, sets.index(true))
    else
      incomplete_category(category)
    end
  end

  def incomplete_category(category)
    incomplete_or_category if category.or_sets?

    incomplete[category] =
      prerequisite_check(incomplete[category].values.flatten)
    used_courses.merge(incomplete[category])
    covert_to_offerings(category)
  end

  def prerequisite_check(courses)
    courses.collect do |course|
      course.can_take(self, transcripts, taken_courses)
    end.flatten.compact
  end

  def covert_to_offerings
    incomplete.each do |course|
      math_classes.push [course, category] if math_class?(course)
    end
    incomplete.map!(&:offerings).flatten!
  end
end
