class Course < ActiveRecord::Base
  has_and_belongs_to_many(:courses,
    :join_table => "prerequisites",
    :foreign_key => "parent_course_id",
    :association_foreign_key => "prerequisite_course_id")
  validates :title, presence: true, uniqueness: true
  validates :subject, presence: true
  validates :course, presence: true, numericality: { only_integer: true }
  
  validates_uniqueness_of :course, scope: [:subject]
end