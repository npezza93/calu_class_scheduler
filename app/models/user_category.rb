# frozen_string_literal: true

# == Schema Information
#
# Table name: user_categories
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  curriculum_category_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  completed              :boolean
#

class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :curriculum_category
  has_many :user_category_courses, dependent: :destroy
  has_many :courses, through: :user_category_courses
  has_one :hidden_user_offering, primary_key: :user_id, foreign_key: :user_id

  has_many :completed_courses, lambda {
    where(user_category_courses: { completed: true })
  }, class_name: "Course", through: :user_category_courses, source: :course
  has_many :offerings, ->{ where(user_category_courses: { completed: false }) },
           through: :user_category_courses

  validates :curriculum_category, uniqueness: { scope: :user }

  scope :completed, lambda {
    where(completed: true).includes(:curriculum_category, :courses)
  }
  scope :incompleted, lambda {
    where(completed: false).includes(
      :curriculum_category, :completed_courses,
      offerings: %i(course days_time user),
    )
  }
end
