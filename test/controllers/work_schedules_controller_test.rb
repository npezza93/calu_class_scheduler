# frozen_string_literal: true

require "test_helper"

class WorkSchedulesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index as student" do
    @user = users(:one)
    sign_in @user

    get work_schedules_path
    assert_response :success
  end

  test "should not get index as advisor" do
    @user = users(:advisor)
    sign_in @user

    get work_schedules_path
    assert_redirected_to :root
    post work_schedules_path, params: {
      day: "M", start_time: Time.now.to_i, format: :js
    }
    assert_redirected_to :root
    delete work_schedule_path(work_schedules(:one))
    assert_redirected_to :root
  end

  test "should create as student" do
    @user = users(:one)
    sign_in @user

    post work_schedules_path, params: {
      day: "M", start_time: Time.now.to_i, format: :js
    }
    assert_response :success
  end

  test "should delete as student" do
    @user = users(:one)
    sign_in @user

    delete work_schedule_path(work_schedules(:one), format: :js)
    assert_response :success
  end
end
