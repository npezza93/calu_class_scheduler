# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id                     :integer          not null, primary key
#  subject                :string(255)
#  course                 :integer
#  title                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  credits                :integer          default(3)
#  minimum_class_standing :string(255)
#  minimum_sat_score      :string(255)
#  minimum_pt             :string(255)
#  description            :text
#

require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "user_pt_method" do
    assert courses(:three).user_pt_method == "pt_d"
  end

  test "can_take 1" do
    assert courses(:one).can_take?(
      users(:one),
      users(:one).transcripts,
      users(:one).taken_courses.ids
    ).include? courses(:one)
  end

  test "can_take 2" do
    assert courses(:two).can_take?(
      users(:two),
      users(:two).transcripts,
      users(:two).taken_courses.ids
    ).empty?
  end

  test "can_take 3" do
    assert courses(:three).can_take?(
      users(:two),
      users(:two).transcripts,
      users(:two).taken_courses.ids
    ).empty?
  end

  test "can not take 4" do
    assert courses(:four).can_take?(
      users(:two),
      users(:two).transcripts,
      users(:two).taken_courses.ids
    ).exclude?(courses(:four))
  end

  test "can_take 5" do
    assert courses(:five).can_take?(
      users(:one),
      users(:one).transcripts,
      users(:one).taken_courses.ids
    ).include? courses(:two)
  end
end
