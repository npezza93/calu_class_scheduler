# frozen_string_literal: true
require "test_helper"

class SchedulesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should get index as student" do
    @user = users(:one)
    sign_in @user

    get :index
    assert_response :success
  end

  test "should not get index as advisor" do
    @user = users(:advisor)
    sign_in @user

    get :index
    assert_redirected_to :root
  end

  test "should destroy schedule as student" do
    @user = users(:one)
    sign_in @user

    assert_difference "Schedule.count", -1 do
      delete :destroy, params: { id: offerings(:one).id }
    end
    assert_redirected_to schedules_path
  end

  test "should not destroy schedule as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference "Schedule.count" do
      delete :destroy, params: { id: offerings(:one).id }
    end
    assert_redirected_to :root
  end

  test "should create schedule as student" do
    @user = users(:one)
    sign_in @user

    assert_difference "Schedule.count" do
      post :create, params: { offering_id: offerings(:two).id }
    end
    assert_redirected_to schedules_path
  end

  test "should not create schedule as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference "Schedule.count" do
      post :create, params: { offering_id: offerings(:two).id }
    end
    assert_redirected_to :root
  end
end
