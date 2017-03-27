# frozen_string_literal: true

require "test_helper"

class SemestersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should change the sessions semester" do
    @user = users(:one)
    sign_in @user

    assert session[:semester_id].blank?

    put :update, params: { id: semesters(:two).id }

    assert_equal session[:semester_id], semesters(:two).id
    assert_redirected_to edit_user_registration_path
  end
end
