require 'test_helper'

class SemestersControllerTest < ActionController::TestCase
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
  end

  test 'should get new as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :new
    assert_response :success
  end

  test 'should not set system as student' do
    @user = users(:one)
    sign_in @user

    put :system, params: { semester: { id: semesters(:two).id } }
    assert_redirected_to :root
  end

  test 'should set session semester as advisor' do
    @user = users(:advisor)
    sign_in @user

    put :set_session, params: { semester: { id: semesters(:two).id } }

    assert_redirected_to :semesters
    assert_equal semesters(:two).semester + ' is now viewable', flash[:notice]
  end

  test 'should set session semester as student' do
    @user = users(:one)
    sign_in @user

    put :set_session, params: { semester: { id: semesters(:two).id } }

    assert_redirected_to :semesters
    assert_equal semesters(:two).semester + ' is now viewable', flash[:notice]
  end

  test 'should set system as advisor' do
    @user = users(:advisor)
    sign_in @user

    put :system, params: { semester: { id: semesters(:two).id } }

    assert_redirected_to :semesters
  end

  test 'should not get new as student' do
    @user = users(:one)
    sign_in @user

    get :new
    assert_redirected_to :root
  end

  test 'should not create because invalid as advisor ' do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference('Semester.count') do
      post :create, params: { semester: { semester: nil } }
    end
  end

  test 'should create as advisor ' do
    @user = users(:advisor)
    sign_in @user

    assert_difference('Semester.count') do
      post :create, params: { semester: { semester: 'Fall 2000' } }
    end

    assert_redirected_to :semesters
    assert_equal 'Fall 2000 has been created as a new semester!', flash[:notice]
  end

  test 'should not post create as student' do
    @user = users(:one)
    sign_in @user

    post :create, params: { semester: { semester: 'Fall 2000' } }
    assert_redirected_to :root
  end
end
