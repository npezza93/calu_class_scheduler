# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules_categories
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  curriculum_category_id :integer
#  semester_id            :integer
#  completed              :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

module Schedules
  class Category < ApplicationRecord
    include SemesterHelpers

    default_scope { order(:curriculum_category_id) }

    belongs_to :user
    belongs_to :curriculum_category

    has_many :category_courses, dependent: :destroy
    has_many :courses, through: :category_courses
    has_many :category_offerings, dependent: :destroy
    has_many :offerings, through: :category_offerings

    validates :curriculum_category, uniqueness: {
      scope: %i(semester_id user_id)
    }

    def self.table_name_prefix
      "schedules_"
    end

    def category_offerings_by_course
      category_offerings.group_by(&:course)
    end
  end
end
