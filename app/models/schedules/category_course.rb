# frozen_string_literal: true

# == Schema Information
#
# Table name: schedule_category_courses
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

    validates :course, uniqueness: { scope: :category_id }
  end
end
