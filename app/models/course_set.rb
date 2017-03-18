# frozen_string_literal: true
# == Schema Information
#
# Table name: course_sets
#
#  id                         :integer          not null, primary key
#  course_id                  :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  curriculum_category_set_id :integer
#

class CourseSet < ApplicationRecord
  belongs_to :course
  belongs_to :curriculum_category_set
end
