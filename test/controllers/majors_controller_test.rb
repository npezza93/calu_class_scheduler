require "test_helper"

class MajorsControllerTest < ActionController::TestCase
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

  test "should get new as advisor" do
    @user = users(:advisor)
    sign_in @user

    get :new
    assert_response :success
  end

  test "should not get new as student" do
    @user = users(:one)
    sign_in @user

    get :new
    assert_redirected_to :root
  end

  test "should not update because invalid as advisor " do
    @user = users(:advisor)
    sign_in @user

    put :update, params: { id: majors(:one), major: { major: nil } }

    assert_equal "MyString", Major.find(majors(:one).id).major
  end

  test "should update as advisor" do
    @user = users(:advisor)
    sign_in @user

    put :update, params: { id: majors(:one), major: { major: "A new major" } }

    assert_equal "A new major", Major.find(majors(:one).id).major
    assert_redirected_to :majors
  end

  test "should not put update as student" do
    @user = users(:one)
    sign_in @user

    put :update, params: { id: majors(:one), major: { major: "major" } }
    assert_redirected_to :root
  end

  test "should not create because invalid as advisor " do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference("Major.count") do
      post :create, params: { major: { major: nil } }
    end
  end

  test "should create as advisor " do
    @user = users(:advisor)
    sign_in @user

    assert_difference("Major.count") do
      post :create, params: { major: { major: "New major" } }
    end

    assert_redirected_to :majors
    assert_equal "New major is a new major!", flash[:notice]
  end

  test "should not post create as student" do
    @user = users(:one)
    sign_in @user

    post :create, params: { major: { major: "new major" } }
    assert_redirected_to :root
  end

  test "should delete major as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_difference("Major.count", -1) do
      delete :destroy, params: { id: majors(:one).id }
    end

    assert_redirected_to :majors
    assert_equal "Major was successfully destroyed.", flash[:notice]
  end

  test "should not delete course as student" do
    @user = users(:one)
    sign_in @user

    delete :destroy, params: { id: majors(:one).id }

    assert_redirected_to :root
  end
end
