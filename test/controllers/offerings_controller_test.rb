# frozen_string_literal: true
require "test_helper"

class OfferingsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should get index, new, and edit as advisor" do
    @user = users(:advisor)
    sign_in @user

    get :index
    assert_response :success

    get :new
    assert_response :success

    get :edit, params: { id: offerings(:one).id }
    assert_response :success
  end

  test "should get index with search as advisor" do
    @user = users(:advisor)
    sign_in @user

    get :index, params: { search: "AAA" }
    assert_response :success
  end

  test "should not do anything as student" do
    @user = users(:one)
    sign_in @user

    get :index
    assert_redirected_to :root
    get :new
    assert_redirected_to :root
    get :edit, params: { id: offerings(:one).id }
    assert_redirected_to :root
    post :create, params: { offering: { course_id: courses(:one).id } }
    assert_redirected_to :root
    delete :destroy, params: { id: offerings(:one).id }
    assert_redirected_to :root
    post :import, params: { offering_file: "file text" }
    assert_redirected_to :root
  end

  test "should update as advisor" do
    @user = users(:advisor)
    sign_in @user

    put :update, params: { id: offerings(:one),
                           offering: { course_id: courses(:one).id } }

    assert_equal courses(:one), Offering.find(offerings(:one).id).course
    assert_redirected_to :offerings
  end

  test "should not update because invalid as advisor " do
    @user = users(:advisor)
    sign_in @user

    put :update, params: { id: offerings(:one), offering: { course_id: nil } }

    assert_equal courses(:two), Offering.find(offerings(:one).id).course
  end

  test "should not put update as student" do
    @user = users(:one)
    sign_in @user

    put :update, params: { id: offerings(:one),
                           offering: { course_id: courses(:one).id } }
    assert_redirected_to :root
  end

  test "should not create because invalid as advisor " do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference("Offering.count") do
      post :create, params: { offering: { course_id: courses(:one).id } }
    end
  end

  test "should create as advisor " do
    @user = users(:advisor)
    sign_in @user

    assert_difference("Offering.count") do
      post :create, params: { offering: {
        course_id: courses(:one).id,
        user_id: users(:advisor).id,
        section: "D3",
        semester_id: semesters(:one).id,
        days_time_id: days_times(:two)
      } }
    end

    assert_redirected_to :offerings
    assert_equal courses(:one).title + " created!", flash[:notice]
  end

  test "should delete offering as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_difference("Offering.count", -1) do
      delete :destroy, params: { id: offerings(:one).id }
    end

    assert_redirected_to :offerings
    assert_equal courses(:two).title + " removed!", flash[:notice]
  end

  test "should not import offerings as advisor" do
    @user = users(:advisor)
    sign_in @user

    post :import,
         params: { offering_file: fixture_file_upload("files/test.jpg") }

    assert_redirected_to offerings_path
  end

  test "should import offerings as advisor" do
    @user = users(:advisor)
    sign_in @user

    post :import, params: {
           offering_file: fixture_file_upload("files/test.csv", "text/csv")
         }

    assert_redirected_to offerings_path
  end
end
