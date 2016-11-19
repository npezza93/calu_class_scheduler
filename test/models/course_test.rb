require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "user_pt_method" do
    assert courses(:three).user_pt_method == "pt_d"
  end

  test "can_take 1" do
    assert courses(:one).can_take(
      users(:one),
      users(:one).transcripts,
      users(:one).taken_courses
    ).include? courses(:one)
  end

  test "can_take 2" do
    assert courses(:two).can_take(
      users(:two),
      users(:two).transcripts,
      users(:two).taken_courses
    ).empty?
  end

  test "can_take 3" do
    assert courses(:three).can_take(
      users(:two),
      users(:two).transcripts,
      users(:two).taken_courses
    ).empty?
  end

  test "can_take 4" do
    assert courses(:four).can_take(
      users(:two),
      users(:two).transcripts,
      users(:two).taken_courses
    ).include? false
  end

  test "can_take 5" do
    assert courses(:five).can_take(
      users(:one),
      users(:one).transcripts,
      users(:one).taken_courses
    ).include? courses(:two)
  end
end
