require "test_helper"

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should get index as advisor" do
    @user = users(:advisor)
    sign_in @user

    get :index

    assert_response :success
  end

  test "should not get index as student" do
    @user = users(:one)
    sign_in @user

    get :index

    assert_redirected_to :root
  end
end
