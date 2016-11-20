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
