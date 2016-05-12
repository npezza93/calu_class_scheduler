module Scheduler::MathClasses
  def math_class?(course)
    course == mat_181 || course == mat_191 ||
      course == mat_199 || course == mat_281
  end

  def math_pt
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
