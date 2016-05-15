class UserCategoryCourse < ApplicationRecord
  belongs_to :user_category
  belongs_to :course
  has_many :offerings, through: :course

  validates :course, uniqueness: { scope: :user_category }

  scope :completed, -> { where(completed: true) }
  scope :incompleted, -> { joins(:offerings).where(completed: false).offerings }
end
