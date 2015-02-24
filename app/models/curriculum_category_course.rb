class CurriculumCategoryCourse < ActiveRecord::Base
  belongs_to :curriculum_category
  belongs_to :course
end
