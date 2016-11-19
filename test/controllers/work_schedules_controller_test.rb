require "test_helper"

class WorkSchedulesControllerTest < ActionController::TestCase
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

  test "should create as student" do
    @user = users(:one)
    sign_in @user

    post :create, params: { work_days_time_id: work_days_times(:day_M_8_30) }
    assert_redirected_to :work_schedules
  end

  test "should not create as advisor" do
    @user = users(:advisor)
    sign_in @user

    post :create, params: { work_days_time_id: work_days_times(:day_M_8_30) }
    assert_redirected_to :root
  end

  test "should create day column as student" do
    @user = users(:one)
    sign_in @user

    post :create, params: { day: "M", type: :day }
    assert_redirected_to :work_schedules
  end

  test "should remove all day columns as student" do
    @user = users(:one)
    sign_in @user

    post :create, params: { day: "M", type: :day }
    assert_redirected_to :work_schedules
  end

  test "should not create day column as advisor" do
    @user = users(:advisor)
    sign_in @user

    post :create, params: { day: "M", type: :day }
    assert_redirected_to :root
  end

  test "should create time row as student" do
    @user = users(:one)
    sign_in @user

    post :create, params: { time: "8:00am", type: :time }
    assert_redirected_to :work_schedules
  end

  test "should remove time row as student" do
    @user = users(:one)
    sign_in @user

    post :create, params: { time: "8:00am", type: :time }
    assert @user.work_days_times.where(
      start_time: DateTime.new(2000, 1, 1, 8)
    ).count.positive?

    post :create, params: { time: "8:00am", type: :time }
    assert @user.work_days_times.where(
      start_time: DateTime.new(2000, 1, 1, 8)
    ).count.zero?

    assert_redirected_to :work_schedules
  end

  test "should not create time row as advisor" do
    @user = users(:advisor)
    sign_in @user

    post :create, params: { time: "8:00am", type: :time }
    assert_redirected_to :root
  end

  test "should delete as student" do
    @user = users(:one)
    sign_in @user

    delete :destroy, params: { id: work_schedules(:one).id }
    assert_redirected_to :work_schedules
  end

  test "should not delete as advisor" do
    @user = users(:advisor)
    sign_in @user

    delete :destroy, params: { id: work_schedules(:two).id }
    assert_redirected_to :root
  end
end
