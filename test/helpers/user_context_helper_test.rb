# frozen_string_literal: true

class UserContextHelperTest < ActionView::TestCase
  test "finds semester from the session" do
    session[:semester_id] = semesters(:spring_2017).id

    assert_equal current_semester, semesters(:spring_2017)
  end
end
