class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :curriculum_category
  has_many :user_category_courses, dependent: :destroy
  has_many :courses, through: :user_category_courses
  has_many :completed_courses,
           ->{ where('user_category_courses.completed = ?', true) },
           class_name: 'Course', through: :user_category_courses,
           source: :course

  has_many :offerings,
           ->{ where('user_category_courses.completed = ?', false) },
           through: :user_category_courses

  validates :curriculum_category, uniqueness: { scope: :user }

  scope :completed, lambda {
    where(completed: true).includes(:curriculum_category, :courses)
  }
  scope :incompleted, lambda {
    where(completed: false).includes(
      {offerings: [:course, :days_time, :user]},
      :curriculum_category, :completed_courses
    )
  }
end
