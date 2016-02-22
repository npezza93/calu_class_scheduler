class Course < ActiveRecord::Base
  has_many :prerequisites, class_name: 'Prerequisites', foreign_key: 'parent_course_id'
  validates :title, presence: true
  validates :subject, presence: true
  validates :course, presence: true, numericality: { only_integer: true }
  validates :credits, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of :course, scope: [:subject]

  before_save :set_class_standing

  has_many :offerings

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

  private

  def set_class_standing
    if minimum_class_standing == 'No minimum class standing'
      minimum_class_standing = nil
    end
  end
end
