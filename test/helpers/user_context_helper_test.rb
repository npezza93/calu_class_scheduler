# frozen_string_literal: true

class UserContextHelperTest < ActionView::TestCase
  test "finds semester from the session" do
    session[:semester_id] = semesters(:two).id

    assert_equal current_semester, semesters(:two)
  end
end
