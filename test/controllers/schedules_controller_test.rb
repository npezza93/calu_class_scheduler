# frozen_string_literal: true

require "test_helper"

class SchedulesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    put semester_path(semesters(:spring_2017))
  end

  test "should get index as student" do
    get schedules_path
    assert_response :success
  end

  test "should not schedule actions as advisor" do
    sign_out @user
    @user = users(:advisor)
    sign_in @user

    get schedules_path
    assert_redirected_to :root
    assert_no_difference "Schedule.count" do
      delete schedule_path(offerings(:one))
    end
    assert_redirected_to :root
    assert_no_difference "Schedule.count" do
      post schedules_path(offering_id: offerings(:two).id)
    end
    assert_redirected_to :root
  end

  test "should destroy schedule as student" do
    assert_difference "Schedule.count", -1 do
      delete schedule_path(offerings(:one), format: :js)
    end

    assert_response :success
  end

  test "should create schedule as student" do
    assert_difference "Schedule.count" do
      post schedules_path(offering_id: offerings(:two).id, format: :js)
    end

    assert_response :success
  end
end
