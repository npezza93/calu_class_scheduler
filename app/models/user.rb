class User < ActiveRecord::Base
  CLASS_STANDINGS =
    { 'Senior' => 1, 'Junior' => 2, 'Sophmore' => 3, 'Freshman' => 4 }.freeze

  # Instance variables for scheduler
  attr_accessor :mat_181, :mat_191, :mat_199, :mat_281, :active_semester,
                :categories, :complete, :incomplete, :used_courses,
                :math_classes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  validates :major, presence: true
  validates :advised_by, presence: true, if: '!advisor'
  validates :email, uniqueness: true
  validates :email,
            format: {
              with: /@calu.edu\Z/, message: 'must be a CalU email address'
            }

  belongs_to :major
  has_many :transcripts
  has_many :taken_courses, through: :transcripts, source: :course
  has_many :schedules, -> { where(semester: Semester.active) }
  has_many :offerings, through: :schedules
  has_many :offering_day_times, through: :offerings, source: :days_time
  has_many :courses, through: :offerings
  has_many :work_schedules, -> { where(semester: Semester.active) }
  has_many :work_days_times, through: :work_schedules

  scope :offering_advisors, lambda {
    where('advisor = ? OR email = ?', true, 'staff@calu.edu')
  }
  serialize :minor, Array

  before_validation do |model|
    model.minor.reject!(&:blank?) if model.minor
  end

  def name
    first_name + ' ' + last_name
  end

  def current_credits
    courses.sum(&:credits)
  end

  def send_for_approval
    UserMailer.submit_for_advising(self).deliver
  end

  def send_approval_submission_confirmation
    UserMailer.approval_submission_confirmation(self).deliver
  end

  def send_approved_confirmation
    UserMailer.approval_confirmation(self).deliver
  end

  def send_approved
    UserMailer.approved(self).deliver
  end

  def advisees
    User.where(advised_by: self)
  end

  def students
    User.where(advisor: false, administrator: false).where.not(advised_by: self)
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
      1, false, true, []
    ).includes(:courses,
               curriculum_category_sets: [
                 { courses: [{ prerequisites: [:course] },
                             { offerings: [:days_time, :user] }] },
                 { course_sets: { course:
                   [:prerequisites, { offerings: [:days_time, :user] }] } }
               ])
  end

  def scheduler
    @complete = {}
    @incomplete = {}

    @used_courses = Set.new
    @math_classes = []

    categories.each do |category|
      courses_for_category(category)
    end

    add_needed_math_classes
  end

  def courses_for_category(category)
    sets = []
    @complete[category] = {}
    @incomplete[category] = {}

    category.curriculum_category_sets.each do |category_set|
      set_mapping = category_set.courses.map do |course|
        taken_courses.to_a.include?(course)
      end
      count = category_set.count

      if !count.nil? && set_mapping.grep(true).count < count
        sets.push(false)
        incomplete[category][category_set] =
          category_set.courses - taken_courses
      elsif !count.nil? && set_mapping.grep(true).count >= count
        sets.push(true)
      elsif count.nil?
        sets.push(set_mapping.inject(:&))
        unless set_mapping.inject(:&)
          incomplete[category][category_set] =
            category_set.courses - taken_courses
        end
      end
      complete[category][category_set] =
        category_set.courses & taken_courses
    end

    if category.set_and_or_flag ? sets.compact.inject(:|) : sets.compact.inject(:&)
      complete[category] = (category.courses & taken_courses).uniq
      incomplete.delete(category)
      if category.set_and_or_flag
        complete[category] =
          (category.curriculum_category_sets[sets.index(true)].courses &
            taken_courses).uniq
      end
    else
      if category.set_and_or_flag
        incomplete[category] = incomplete[category].select do |_, value|
          value.count == incomplete[category].map { |_, v| v.count }.min
        end
        complete[category] = complete[category].select do |_, value|
          value.count == complete[category].map { |_, v| v.count }.max
        end
        temp_set = complete[category].keys.first
        temp_courses = complete[category].values.flatten.uniq
        complete[category] = {}
        complete[category][temp_set] = temp_courses
      end
      incomplete[category] =
        prerequisite_check(incomplete[category].values.flatten)
      used_courses.merge(incomplete[category])
      incomplete[category].each do |course|
        math_classes << [course, category] if math_class?(course)
      end
      incomplete[category].map!(&:offerings)
      incomplete[category] = incomplete[category].flatten
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
      prerequisite_groups = course.prerequisite_groups

      prerequisite_groups = prerequisite_groups.map do |prerequisite_group|
        prerequisite_group.prerequisites.map do |prereq|
          ok_courses << failed_class(prereq) unless failed_class(prereq).nil?
          passed_class?(prereq)
        end.inject(:&)
      end.inject(:|)

      ok_courses << course if can_take_course?(course, prerequisite_groups)
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
    categories = math_classes.collect(&:second)

    mat_prereq = {}
    mat_prereq[mat_281] = prerequisite_check([mat_281]).include? mat_281
    mat_prereq[mat_199] = prerequisite_check([mat_199]).include? mat_199
    mat_prereq[mat_191] = prerequisite_check([mat_191]).include? mat_191
    mat_prereq[mat_181] = prerequisite_check([mat_181]).include? mat_181

    if !mat_prereq.values.inject(:|)
      dma = Course.find_by(subject: 'DMA', course: 92)
      return [dma, categories.sort.last] if prerequisite_check([dma]).include? dma
      nil
    else
      highest_avail = mat_prereq.select { |k, v| v && !taken_courses.include?(k) }
      return [highest_avail.first[0], categories.sort.last]
    end
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

  def self.search(search)
    return nil if search.nil? || search == ''

    where('first_name LIKE ?
           OR last_name LIKE ?
           OR email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
      .where(advisor: false, administrator: false).to_a
  end

  def self.sort_options
    ['All Students', 'My Advisees']
  end
end
