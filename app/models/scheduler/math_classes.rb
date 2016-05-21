module Scheduler::MathClasses
  def math_class?(course)
    pt_math_classes.include? course
  end

  def math_pt
    categories = math_classes.collect(&:second).sort.last
    mat_prereq = eval_prereq_maths

    if !mat_prereq.inject(:|) && need_dma?
      [dma, categories]
    else
      [mat_prereq.find do |k, v|
        v && !taken_courses.include?(k)
      end[0], categories]
    end
  end

  def need_dma?
    prerequisite_check([dma]).include? dma
  end

  def eval_prereq_maths
    math_check = prerequisite_check(pt_math_classes)
    [
      math_check.include?(mat_281), math_check.include?(mat_199),
      math_check.include?(mat_191), math_check.include?(mat_181)
    ]
  end

  def add_needed_math_classes
    unless math_classes.empty?
      needed = math_pt(math_classes)
      if !needed.nil? && used_courses.add?(needed[0])
        offerings = Offering.where(course: needed[0], semester: active_semester)
        incomplete[math_class_placed_in[1]] += offerings unless offerings.blank?
      end
    end
  end
end
