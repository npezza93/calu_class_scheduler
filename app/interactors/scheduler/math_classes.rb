# frozen_string_literal: true

class Scheduler
  module MathClasses
    def pt_math_classes
      @pt_math_classes ||= [mat181, mat191, mat199, mat281]
    end

    def dma
      @dma ||= Course.find_by(subject: "DMA", course: 92)
    end

    def mat181
      @mat181 ||= Course.find_by(subject: "MAT", course: 181)
    end

    def mat191
      @mat191 ||= Course.find_by(subject: "MAT", course: 191)
    end

    def mat199
      @mat199 ||= Course.find_by(subject: "MAT", course: 199)
    end

    def mat281
      @mat281 ||= Course.find_by(subject: "MAT", course: 281)
    end

    def math_class?(course)
      pt_math_classes.include? course
    end

    def add_needed_math_classes
      return if math_classes.empty? || (needed = math_pt).blank?

      add_math_classes_to_db(needed)
    end

    def math_pt
      mat_prereq = eval_prereq_maths

      if !mat_prereq.inject(:|) && need_dma?
        [dma, dma_math_category]
      else
        valid_classes =
          pt_math_classes.values_at(*mat_prereq.each_index.select { |c| c })
        math_classes.select do |math|
          valid_classes.include? math.first
        end
      end
    end

    def need_dma?
      prerequisite_check([dma]).include? dma
    end

    def eval_prereq_maths
      math_check = prerequisite_check(pt_math_classes)
      [
        math_check.include?(mat181), math_check.include?(mat191),
        math_check.include?(mat199), math_check.include?(mat281)
      ]
    end

    def dma_math_category
      math_classes.collect(&:second).sort.first
    end

    def add_math_classes_to_db(needed_courses)
      needed_courses.each do |needed_course|
        next unless used_courses.add?(needed_course.first)

        user.user_categories.find_by(
          curriculum_category_id: needed_course.second.id, completed: false
        ).user_category_courses.where(
          course_id: needed_course.first.id, completed: false
        ).first_or_create
      end
    end
  end
end
