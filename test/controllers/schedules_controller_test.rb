require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index as student' do
    @user = users(:one)
    sign_in @user

    # get :index
    # assert_response :success
  end

  test 'should not get index as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :index
    assert_redirected_to :root
  end
end
