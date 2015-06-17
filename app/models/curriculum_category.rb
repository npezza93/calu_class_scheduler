class CurriculumCategory < ActiveRecord::Base
  belongs_to :major
  validates :category, presence: true

  validates_uniqueness_of :category, scope: [:major, :minor]
  has_many :curriculum_category_sets
  has_many :course_sets, through: :curriculum_category_sets
  has_many :courses, through: :course_sets
  has_many :offerings, through: :courses
end
