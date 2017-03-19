# frozen_string_literal: true
require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index as advisor" do
    @user = users(:advisor)
    sign_in @user

    get users_path

    assert_response :success
  end

  test "should show student as advisor" do
    @user = users(:advisor)
    sign_in @user

    get user_path(users(:one))

    assert_response :success
  end

  test "should not get index as student" do
    @user = users(:one)
    sign_in @user

    get users_path

    assert_redirected_to :root
  end
end
