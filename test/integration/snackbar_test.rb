# frozen_string_literal: true
require "test_helper"

class SnackbarTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "snack bar is created on screen" do
    post user_session_path

    assert_select(".mdc-snackbar")
    assert_select(".mdc-snackbar__text", "Invalid Email or password.")
  end
end
