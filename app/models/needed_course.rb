class NeededCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user
  belongs_to :semester

  validates_uniqueness_of :course, scope: [:user, :semester]
end
