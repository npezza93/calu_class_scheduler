class CurriculumCategory < ActiveRecord::Base
  belongs_to :major
  validates :category, presence: true
  validates :minor, presence: true
  
  validates_uniqueness_of :category, scope: [:major, :minor]
  has_many :curriculum_category_sets, dependent: :destroy
  has_many :course_sets, through: :curriculum_category_sets, dependent: :destroy
  has_many :courses, through: :course_sets
  has_many :offerings, through: :courses

  accepts_nested_attributes_for :curriculum_category_sets,
                                allow_destroy: true, reject_if: :all_blank
end
