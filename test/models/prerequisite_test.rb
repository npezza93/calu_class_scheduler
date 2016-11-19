require "test_helper"

class PrerequisitesTest < ActiveSupport::TestCase
  test "should return true since no minimum grade" do
    assert prerequisites(:two).passed_minimum_grade? users(:one).transcripts
  end

  test "should return since user passed c minus" do
    assert prerequisites(:three).passed_minimum_grade? users(:one).transcripts
  end
end
