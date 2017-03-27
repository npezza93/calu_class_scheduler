# frozen_string_literal: true

# == Schema Information
#
# Table name: user_categories
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  curriculum_category_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  completed              :boolean
#

require "test_helper"

class UserCategoryTest < ActiveSupport::TestCase
  test "has at least one completed course" do
    refute user_categories(:one).completed_courses.empty?
  end
end
