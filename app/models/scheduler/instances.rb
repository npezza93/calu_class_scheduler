module Scheduler::Instances
  def complete
    @complete ||= {}
  end

  def incomplete
    @incomplete ||= {}
  end

  def used_courses
    @used_courses ||= Set.new
  end

  def math_classes
    @math_classes ||= []
  end

  def pt_math_classes
    @pt_math_classes ||= [mat181, mat191, mat199, mat281]
  end

  def dma
    @dma ||= Course.find_by(subject: "DMA", course: 92)
  end

  def mat181
    @mat181 ||= Course.find_by(subject: "MAT", course: "181")
  end

  def mat191
    @mat191 ||= Course.find_by(subject: "MAT", course: "191")
  end

  def mat199
    @mat199 ||= Course.find_by(subject: "MAT", course: "199")
  end

  def mat281
    @mat281 ||= Course.find_by(subject: "MAT", course: "281")
  end

  def active_semester
    @active_semester ||= Semester.active
  end

  def categories(course_id = nil)
    @categories ||= CurriculumCategory.where(
      "(major_id = ? and minor = ?) or (minor = ? and major_id IN (?))",
      major_id, false, true, minor
    ).includes(:courses, curriculum_category_sets: {
      courses: { prerequisites: :course }
    }).with_course(course_id).to_a
  end
end
