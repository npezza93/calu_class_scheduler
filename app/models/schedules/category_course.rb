# frozen_string_literal: true

# == Schema Information
#
# Table name: schedules_category_courses
#
#  id          :integer          not null, primary key
#  category_id :integer
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Schedules
  class CategoryCourse < ApplicationRecord
    belongs_to :category
    belongs_to :course

    validates :course_id, uniqueness: { scope: :category_id }

    def self.table_name_prefix
      "schedules_"
    end
  end
end
