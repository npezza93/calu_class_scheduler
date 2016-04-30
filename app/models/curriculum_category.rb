class CurriculumCategory < ActiveRecord::Base
  belongs_to :major
  validates :category, presence: true
  validates :minor, inclusion: { in: [true, false] }

  validates_uniqueness_of :category, scope: [:major, :minor]
  has_many :curriculum_category_sets, dependent: :destroy
  has_many :course_sets, through: :curriculum_category_sets, dependent: :destroy
  has_many :courses, through: :course_sets
  has_many :offerings, through: :courses

  accepts_nested_attributes_for :curriculum_category_sets,
                                allow_destroy: true, reject_if: :all_blank

  def pretty_set_flag
    if set_and_or_flag == 'true'
      'One of the following sections has to be completed'
    else
      'All the sections have to be completed'
    end
  end
end
