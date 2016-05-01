class Scheduler
  attr_accessor :user, :complete, :incomplete, :used_courses, :math_classes

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

  def taken_courses
    @taken_courses ||= user.taken_courses
  end

  def categories
    @categories ||=
      CurriculumCategory.eager_load(curriculum_category_sets: :courses)
                        .major(user.major_id)
  end

  def initialize(user)
    @user = user
  end

  def perform
    self.complete = {}
    self.incomplete = {}

    self.used_courses = Set.new
    self.math_classes = []

    categories.each do |category|
      init_category(category)
      eval_category(category)
    end

    # add_needed_math_classes
  end

  def init_category(category)
    complete[category] = {}
    incomplete[category] = {}
  end

  def eval_category(category)
    sets = []

    category.curriculum_category_sets.each do |category_set|
      sets << eval_category_set(category, category_set)
    end

    # if category_complete?(category, sets)
    #   complete_category(category, sets.index(true))
    # else
    #   incomplete_category(category)
    # end
  end

  def eval_category_set(category, category_set)
    set_mapping = category_set.courses.map do |course|
      taken_courses.to_a.include?(course)
    end
    complete[category][category_set] = category_set.courses & taken_courses

    get_incomplete_from_set(
      category,
      category_set,
      category_set.count,
      set_mapping
    )
  end

  def get_incomplete_from_set(category, category_set, count, set_mapping)
    if !count.nil?
      eval_count_of_set(category, category_set, count, set_mapping)
    else
      unless set_mapping.inject(:&)
        add_incomplete_from_set(category, category_set)
      end
      set_mapping.inject(:&)
    end
  end

  def eval_count_of_set(category, category_set, count, set_mapping)
    if set_mapping.grep(true).count < count
      add_incomplete_from_set(category, category_set)
      false
    else
      true
    end
  end

  def add_incomplete_from_set(category, category_set)
    incomplete[category][category_set] = category_set.courses - taken_courses
  end

  def category_complete?(category, sets)
    if category.set_and_or_flag == 'true'
      sets.compact.inject(:|)
    else
      sets.compact.inject(:&)
    end
  end

  def add_first_complete_set_for_or_category(category, set_index)
    complete[category] =
      (category.curriculum_category_sets[set_index].courses &
        taken_courses).uniq
  end

  def complete_category(category, set_index)
    complete[category] = (category.courses & taken_courses).uniq
    incomplete.delete(category)
    if category.set_and_or_flag == 'true'
      add_first_complete_set_for_or_category(category, set_index)
    end
  end

  def incomplete_category(category)
    incomplete_or_category(category) if category.set_and_or_flag == 'true'
    incomplete[category] =
      prerequisite_check(incomplete[category].values.flatten)
    used_courses.merge(incomplete[category])
    covert_to_offerings(category)
  end

  def covert_to_offerings(category)
    incomplete[category].each do |course|
      math_classes << [course, category] if math_class?(course)
    end
    incomplete[category].map!(&:offerings).flatten!
  end

  def incomplete_or_category(category)
    reset_incomplete_of_or_category_sets(category)
    reset_complete_of_or_category_sets(category)

    temp_set = complete[category].keys.first
    temp_courses = complete[category].values.flatten.uniq
    complete[category] = {}
    complete[category][temp_set] = temp_courses
  end

  def reset_incomplete_of_or_category_sets(category)
    incomplete[category] = incomplete[category].select do |_, value|
      value.count == incomplete[category].map { |_, v| v.count }.min
    end
  end

  def reset_complete_of_or_category_sets(category)
    complete[category] = complete[category].select do |_, value|
      value.count == complete[category].map { |_, v| v.count }.max
    end
  end

  def math_class?(course)
    course == mat_181 ||
      course == mat_191 ||
      course == mat_199 ||
      course == mat_281
  end

  def prerequisite_check(courses)
    ok_courses = []
    courses.each do |course|
      groups = course.prerequisite_groups.map do |group|
        group.prerequisites.map do |prereq|
          ok_courses << failed_class(prereq) unless failed_class(prereq).nil?
          passed_class?(prereq)
        end.inject(:&)
      end.inject(:|)

      ok_courses << course if can_take_course?(course, groups)
    end
    ok_courses
  end

  def can_take_course?(course, prerequisite_groups)
    (!prerequisite_groups.nil? &&
      passed_tests?(course) ||
      passed_pt_or_sat?(course)
    ) || passed_tests?(course) || passed_sat?(course)
  end

  def passed_pt_or_sat?(course)
    pt_check(course.minimum_pt) || passed_sat?(course)
  end

  def passed_tests?(course)
    !course.minimum_pt? &&
      eligible_class_standing?(course) &&
      passed_sat?(course)
  end

  def eligible_class_standing?(course)
    return true unless course.minimum_class_standing?
    return false unless class_standing?

    CLASS_STANDINGS[class_standing] <=
      CLASS_STANDINGS[course.minimum_class_standing]
  end

  def passed_sat?(course)
    return true unless course.minimum_sat_score?

    send("sat_#{course.minimum_sat_score}")
  end

  def failed_class(prerequisite)
    return nil if taken_courses.to_a.include?(prerequisite.course) ||
                  passed_grade?(prerequisite)

    prerequisite.course
  end

  def passed_class?(prerequisite)
    return false if taken_courses.to_a.include?(prerequisite.course)

    passed_grade?(prerequisite)
  end

  def passed_grade?(prerequisite)
    prerequisite.minimum_grade.nil? ||
      passed_grade_c?(prerequisite.course) ||
      passed_grade_c_minus?(prerequisite.course)
  end

  def passed_grade_c?(course)
    taken_courses.to_a.include?(course) &&
      transcripts.find(course.id).grade_c &&
      course.minimum_grade == 'C'
  end

  def passed_grade_c_minus?(course)
    taken_courses.to_a.include?(course) &&
      transcripts.find(course.id).grade_c_minus &&
      course.minimum_grade == 'C-'
  end

  def pt_check(min_pt)
    if min_pt == 'A' || min_pt == 'B' || min_pt == 'C' || min_pt == 'D-'
      send("pt_#{min_pt.tr('-', '').downcase}") == 1
    elsif min_pt == 'D'
      pt_d == 3
    else
      false
    end
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
          course: needed_maths[0], semester: active_semester)
        incomplete[math_class_placed_in[1]] += offerings unless offerings.blank?
      end
    end
  end
end
