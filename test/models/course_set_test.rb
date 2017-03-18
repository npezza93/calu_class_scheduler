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

require "test_helper"

class CourseSetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
