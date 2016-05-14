class Course < ApplicationRecord
  has_many :prerequisite_groups, dependent: :destroy
  has_many :prerequisites, through: :prerequisite_groups, dependent: :destroy
  has_many :courses, through: :prerequisites
  has_many :offerings

  accepts_nested_attributes_for :prerequisite_groups,
                                allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true
  validates :subject, presence: true
  validates :course, presence: true, numericality: { only_integer: true }
  validates :credits, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of :course, scope: [:subject]

  CLASS_STANDINGS =
    { 'Senior' => 1, 'Junior' => 2, 'Sophmore' => 3, 'Freshman' => 4 }.freeze

  PLACEMENT_TEST_PARTS = [
    ['No Part Must Be Passed', ''],
    ['Pass Part A', 'A'],
    ['Pass Part A', 'A'],
    ['Pass Part B', 'B'],
    ['Pass Part C', 'C'],
    ['Pass Part D (7-9)', 'D-'],
    ['Pass Part D (10 or above)', 'D']
  ].freeze

  YEARS = [
    ['No minimum class standing', ''],
    %w(Senior Senior),
    %w(Junior Junior),
    %w(Sophmore Sophmore),
    %w(Freshman Freshman)
  ].freeze

  SAT_SCORES = [
    ['No minimum SAT score', ''],
    ['440 on Mathematics or better', '440'],
    ['520 on Mathematics or better', '520'],
    ['580 on Mathematics or better', '580'],
    ['640 on Mathematics or better', '640'],
    ['700 on Mathematics or better', '700']
  ].freeze

  def pretty_course
    subject + course.to_s + ': ' + title
  end

  def completed_prerequisites(transcript, courses_taken)
    prerequisite_groups.map do |group|
      group.prerequisites.map do |prereq|
        prereq.passed?(transcript, courses_taken)
      end.compact
    end.flatten
  end

  def can_take(user, transcript, courses_taken)
    failed_prereqs = completed_prerequisites(transcript, courses_taken)
    unless failed_prereqs.any?
      if passed_tests?(user) || passed_placement_test_or_sat?(user)
        failed_prereqs.push self
      end
    end
    failed_prereqs
  end

  def passed_tests?(user)
    !minimum_pt? &&
      eligible_class_standing?(user) &&
      passed_sat?(user)
  end

  def eligible_class_standing?(user)
    return true unless minimum_class_standing?
    return false unless user.class_standing?

    CLASS_STANDINGS[user.class_standing] <=
      CLASS_STANDINGS[minimum_class_standing]
  end

  def passed_sat?(user)
    return true unless minimum_sat_score?

    user.send("sat_#{minimum_sat_score}")
  end

  def passed_placement_test_or_sat?(user)
    minimum_pt? && (passed_placement_test?(user) || passed_sat?(user))
  end

  def passed_placement_test?(user)
    if %w(A B C D-).include? minimum_pt
      user.send(user_pt_method) == 1
    elsif minimum_pt == 'D'
      user.pt_d == 3
    else
      false
    end
  end

  def user_pt_method
    "pt_#{minimum_pt.tr('-', '').downcase}"
  end

  def self.search(search)
    if search.nil? || search == ''
      all
    else
      search = search.downcase
      where('LOWER(title) LIKE ?
             OR LOWER(subject) LIKE ?', "%#{search}%", "%#{search}%")
    end.order(:subject, :course).group_by(&:subject)
  end
end
