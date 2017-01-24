# frozen_string_literal: true
class CourseSet < ApplicationRecord
  belongs_to :course
  belongs_to :curriculum_category_set
end
