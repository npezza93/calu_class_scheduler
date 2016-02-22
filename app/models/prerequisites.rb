class Prerequisites < ActiveRecord::Base
  belongs_to :parent_course,
             class_name: 'Course', foreign_key: 'parent_course_id'

  belongs_to :prerequisite_course,
             class_name: 'Course', foreign_key: 'prerequisite_course_id'

  validates :parent_course_id,
            uniqueness: { scope: [:prerequisite_course, :course_group_id] }
end
