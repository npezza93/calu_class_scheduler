class CurriculumCategorySet < ActiveRecord::Base
  belongs_to :curriculum_category
  has_many :course_set
  has_many :courses, through: :course_set
  
  validates :count, numericality: { only_integer: true }, allow_blank: true
end
