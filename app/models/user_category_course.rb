# frozen_string_literal: true
# == Schema Information
#
# Table name: user_category_courses
#
#  id               :integer          not null, primary key
#  user_category_id :integer
#  course_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  completed        :boolean
#

class UserCategoryCourse < ApplicationRecord
  belongs_to :user_category
  belongs_to :course
  has_many :offerings, through: :course

  validates :course, uniqueness: { scope: :user_category }

  scope :completed, -> { where(completed: true) }
  scope :incompleted, -> { joins(:offerings).where(completed: false).offerings }
end
