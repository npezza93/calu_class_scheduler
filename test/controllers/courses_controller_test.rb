require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :index
    assert_response :success
  end

  test 'should not get index as student' do
    @user = users(:one)
    sign_in @user

    get :index
    assert_redirected_to :root
    get :new
    assert_redirected_to :root
    get :edit, params: { id: courses(:one).id }
    assert_redirected_to :root
  end

  test 'should get new as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :new
    assert_response :success
  end

  test 'should get edit as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :edit, params: { id: courses(:one).id }
    assert_response :success
  end

  test 'should not update because invalid as advisor ' do
    @user = users(:advisor)
    sign_in @user

    put :update, params: { id: courses(:one), course: { title: nil } }

    assert_equal 'Course 1', Course.find(courses(:one).id).title
  end

  test 'should update as advisor' do
    @user = users(:advisor)
    sign_in @user

    put :update, params: { id: courses(:one), course: { title: 'A course' } }

    assert_equal 'A course', Course.find(courses(:one).id).title
    assert_redirected_to :courses
  end

  test 'should not put update as student' do
    @user = users(:one)
    sign_in @user

    put :update, params: { id: courses(:one), course: { title: 'CSC' } }
    assert_redirected_to :root
  end

  test 'should not create because invalid as advisor ' do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference('Course.count') do
      post :create, params: { course: { title: 'CSC' } }
    end
  end

  test 'should create as advisor ' do
    @user = users(:advisor)
    sign_in @user

    assert_difference('Course.count') do
      post :create, params: {
        course: { title: 'Course 1', subject: 'CCC', course: 123 }
      }
    end

    assert_redirected_to :courses
    assert_equal 'Course 1 was successfully created!', flash[:notice]
  end

  test 'should not post create as student' do
    @user = users(:one)
    sign_in @user

    post :create, params: { course: { title: 'CSC' } }
    assert_redirected_to :root
  end

  test 'should delete course as advisor' do
    @user = users(:advisor)
    sign_in @user

    assert_difference('Course.count', -1) do
      delete :destroy, params: { id: courses(:one).id }
    end

    assert_redirected_to :courses
    assert_equal courses(:one).title + ' was successfully destroyed.',
                 flash[:notice]
  end

  test 'should not delete course as student' do
    @user = users(:one)
    sign_in @user

    delete :destroy, params: { id: courses(:one).id }

    assert_redirected_to :root
  end
end
