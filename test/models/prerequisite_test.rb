# frozen_string_literal: true

# == Schema Information
#
# Table name: prerequisites
#
#  id                    :integer          not null, primary key
#  course_id             :integer
#  created_at            :datetime
#  updated_at            :datetime
#  prerequisite_group_id :integer
#  minimum_grade         :string(255)
#

require "test_helper"

class PrerequisiteTest < ActiveSupport::TestCase
  test "should return true since no minimum grade" do
    assert prerequisites(:two).passed_minimum_grade? users(:one).transcripts
  end

  test "should return since user passed c minus" do
    assert prerequisites(:three).passed_minimum_grade? users(:one).transcripts
  end
end
