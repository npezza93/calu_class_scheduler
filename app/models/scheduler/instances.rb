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

  def dma
    @dma ||= Course.find_by(subject: 'DMA', course: 92)
  end

  def mat_181
    @mat_181 ||= Course.find_by(subject: 'MAT', course: '181')
  end

  def mat_191
    @mat_191 ||= Course.find_by(subject: 'MAT', course: '191')
  end

  def mat_199
    @mat_199 ||= Course.find_by(subject: 'MAT', course: '199')
  end

  def mat_281
    @mat_281 ||= Course.find_by(subject: 'MAT', course: '281')
  end

  def active_semester
    @active_semester ||= Semester.active
  end

  def categories
    @categories ||= CurriculumCategory.where(
      '(major_id = ? and minor =?) or (minor = ? and major_id IN (?))',
      major_id, false, true, minor
    ).includes(:courses, curriculum_category_sets: [{
      courses: [{
        prerequisites: [{ course: { offerings: [:days_time, :user] } }]
      }, { offerings: [:days_time, :user] }]
    }]).to_a
  end
end
