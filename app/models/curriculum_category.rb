class CurriculumCategory < ActiveRecord::Base
  belongs_to :major
  validates :category, presence: true
  validates :required_amount_of_credits, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :major, presence: true
  
  validates_uniqueness_of :category, scope: [:major]
  has_many :curriculum_category_courses
end
