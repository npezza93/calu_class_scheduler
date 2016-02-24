class Prerequisite < ActiveRecord::Base
  belongs_to :prerequisite_group

  belongs_to :course

  validates :parent_course_id,
            uniqueness: { scope: [:prerequisite_course, :course_group_id] }
end
