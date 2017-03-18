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

require "test_helper"

class UserCategoryCourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
