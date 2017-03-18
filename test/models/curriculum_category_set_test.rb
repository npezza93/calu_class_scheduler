# frozen_string_literal: true
# == Schema Information
#
# Table name: curriculum_category_sets
#
#  id                     :integer          not null, primary key
#  curriculum_category_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#  count                  :integer
#

require "test_helper"

class CurriculumCategorySetTest < ActiveSupport::TestCase
  test "nil count display text" do
    assert(
      curriculum_category_sets(:one).pretty_count == "All courses are required"
    )
  end

  test "has count display text" do
    assert curriculum_category_sets(:two).pretty_count ==
      "Choose one of the following"
  end
end
