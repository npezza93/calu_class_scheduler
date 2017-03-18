# frozen_string_literal: true
# == Schema Information
#
# Table name: curriculum_categories
#
#  id              :integer          not null, primary key
#  category        :string(255)
#  major_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  minor           :boolean
#  set_and_or_flag :string
#

require "test_helper"

class CurriculumCategoryTest < ActiveSupport::TestCase
  test "if the sets are to be ored" do
    refute curriculum_categories(:one).or_sets?
  end

  test "scheduler display text" do
    assert curriculum_categories(:one).scheduler_minor_display.nil?
  end

  test "display text" do
    assert curriculum_categories(:one).display == "Communication Skills"
  end

  test "display and set text" do
    assert curriculum_categories(:one).pretty_set_flag ==
            "All the sections have to be completed"
  end

  test "display or set text" do
    assert curriculum_categories(:three).pretty_set_flag ==
            "One of the following sections has to be completed"
  end

  test "or complete?" do
    assert curriculum_categories(:three).complete? [true, false]
    refute curriculum_categories(:three).complete? [false, false]
  end

  test "and complete?" do
    assert curriculum_categories(:one).complete? [true, true]
    refute curriculum_categories(:one).complete? [true, false]
  end
end
