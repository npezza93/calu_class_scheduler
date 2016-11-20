class CurriculumCategory < ApplicationRecord
  belongs_to :major
  has_many :user_categories, dependent: :destroy
  has_many :curriculum_category_sets, dependent: :destroy
  has_many :course_sets, through: :curriculum_category_sets, dependent: :destroy
  has_many :courses, through: :course_sets
  has_many :offerings, through: :courses

  validates :category, presence: true
  validates :minor, inclusion: { in: [true, false] }
  validates_uniqueness_of :category, scope: [:major, :minor]

  accepts_nested_attributes_for :curriculum_category_sets, allow_destroy: true,
                                                           reject_if: :all_blank

  scope :major, ->(major_id) { where(major_id: major_id, minor: false) }
  scope :with_course, lambda { |course_id|
    joins(:course_sets).where(course_sets: { course_id: course_id })
  }
  def pretty_set_flag
    if or_sets?
      "One of the following sections has to be completed"
    else
      "All the sections have to be completed"
    end
  end

  def scheduler_minor_display
    " - #{major.major} Minor" if minor
  end

  def display
    "#{category}#{scheduler_minor_display}"
  end

  def complete?(sets)
    if or_sets?
      sets.compact.inject(:|)
    else
      sets.compact.inject(:&)
    end
  end

  def or_sets?
    set_and_or_flag == "true"
  end
end
