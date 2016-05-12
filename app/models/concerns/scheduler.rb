module Scheduler
  include Scheduler::Instances
  include Scheduler::CompleteCategory
  include Scheduler::IncompleteOrCategory
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
    sets = []

    category.curriculum_category_sets.each do |category_set|
      sets << eval_category_set(category, category_set)
    end

    if category.complete?(sets)
      complete_category(category, sets.index(true))
    else
      incomplete_category(category)
    end
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

  def incomplete_category(category)
    incomplete_or_category if category.or_sets?

    incomplete[category] =
      prerequisite_check(incomplete[category].values.flatten)
    used_courses.merge(incomplete[category])
    covert_to_offerings(category)
  end

  def prerequisite_check(courses)
    courses.collect do |course|
      course.can_take(user, transcript, taken_courses)
    end.flatten.compact
  end

  def covert_to_offerings
    incomplete.each do |course|
      math_classes << [course, category] if math_class?(course)
    end
    incomplete.map!(&:offerings).flatten!
  end

  def math_pt(math_classes)
    category = math_classes.collect(&:second).sort.last
    mat_prereq = eval_prereq_maths

    if !mat_prereq.inject(:|) && need_dma?
      [dma, category]
    else
      [mat_prereq.find do |k, v|
        v && !taken_courses.include?(k)
      end[0], category]
    end
  end

  def need_dma?
    prerequisite_check([dma]).include? dma
  end

  def eval_prereq_maths
    math_check = prerequisite_check([mat_281, mat_199, mat_191, mat_181])
    [
      math_check.include?(mat_281),
      math_check.include?(mat_199),
      math_check.include?(mat_191),
      math_check.include?(mat_181)
    ]
  end

  def add_needed_math_classes
    unless @math_classes.empty?
      needed_maths = math_pt(@math_classes)
      if !needed_maths.nil? && @used_courses.add?(needed_maths[0])
        offerings = Offering.where(
          course: needed_maths[0], semester: active_semester
        )
        incomplete[math_class_placed_in[1]] += offerings unless offerings.blank?
      end
    end
  end
end
