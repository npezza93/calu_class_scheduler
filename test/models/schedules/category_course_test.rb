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

require "test_helper"

module Schedules
  class CategoryCourseTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
