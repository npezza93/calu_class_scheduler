class CurriculumCategoryCourse < ActiveRecord::Base
  belongs_to :curriculum_category
  belongs_to :course
  
  validates_uniqueness_of :course, scope: :curriculum_category
  
  validates :course, presence: true
end
