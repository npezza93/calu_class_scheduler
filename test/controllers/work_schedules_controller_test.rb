require 'test_helper'

class WorkSchedulesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index as student' do
    @user = users(:one)
    sign_in @user

    get :index
    assert_response :success
  end

  test 'should not get index as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :index
    assert_redirected_to :root
  end

  test 'should create as student' do
    @user = users(:one)
    sign_in @user

    post :create, params: { work_days_time_id: work_days_times(:one) }
    assert_redirected_to :work_schedules
  end

  test 'should not create as advisor' do
    @user = users(:advisor)
    sign_in @user

    post :create, params: { work_days_time_id: work_days_times(:one) }
    assert_redirected_to :root
  end

  test 'should create day column as student' do
    @user = users(:one)
    sign_in @user

    post :create_day, params: { day: 'M' }
    assert_redirected_to :work_schedules
  end

  test 'should remove all day columns as student' do
    @user = users(:one)
    sign_in @user
    binding.pry
    post :create_day, params: { day: 'M' }
    assert_redirected_to :work_schedules
  end

  test 'should not create day column as advisor' do
    @user = users(:advisor)
    sign_in @user

    post :create_day, params: { day: 'M' }
    assert_redirected_to :root
  end

  test 'should create time row as student' do
    @user = users(:one)
    sign_in @user

    post :create_time, params: { time: '8:00am' }
    assert_redirected_to :work_schedules
  end

  test 'should not create time row as advisor' do
    @user = users(:advisor)
    sign_in @user

    post :create_time, params: { time: '8:00am' }
    assert_redirected_to :root
  end

  test 'should delete as student' do
    @user = users(:one)
    sign_in @user

    delete :destroy, params: { id: work_days_times(:one).id }
    assert_redirected_to :work_schedules
  end

  test 'should not delete as advisor' do
    @user = users(:advisor)
    sign_in @user

    delete :destroy, params: { id: work_days_times(:one).id }
    assert_redirected_to :root
  end
end
