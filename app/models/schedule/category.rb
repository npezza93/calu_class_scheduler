# frozen_string_literal: true

# == Schema Information
#
# Table name: schedule_categories
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  curriculum_category_id :integer
#  semester_id            :integer
#  completed              :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Schedule
  class Category < ApplicationRecord
    include SemesterHelpers

    belongs_to :user
    belongs_to :curriculum_category

    has_many :category_courses, dependent: :destroy
    has_many :courses, through: :category_courses
    has_many :category_offerings, dependent: :destroy
    has_many :offerings, through: :category_offerings

    validates :curriculum_category, uniqueness: {
      scope: %i(semester_id user_id)
    }

    scope :completed, lambda {
      where(completed: true).includes(:curriculum_category, :courses)
    }
    scope :incompleted, lambda {
      where(completed: false).includes(
        :curriculum_category, offerings: %i(course days_time user),
      )
    }
  end
end
