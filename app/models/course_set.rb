class CourseSet < ActiveRecord::Base
  belongs_to :course
  belongs_to :curriculum_category_set
end
