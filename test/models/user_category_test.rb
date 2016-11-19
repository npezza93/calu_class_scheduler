require "test_helper"

class UserCategoryTest < ActiveSupport::TestCase
  test "has at least one completed course" do
    refute user_categories(:one).completed_courses.empty?
  end
end
