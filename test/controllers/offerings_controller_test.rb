# frozen_string_literal: true
require "test_helper"

class OfferingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index, new, and edit as advisor" do
    @user = users(:advisor)
    sign_in @user

    get course_offerings_path(courses(:one))
    assert_response :success

    get new_course_offering_path(courses(:one))
    assert_response :success

    get edit_course_offering_path(courses(:two), offerings(:one))
    assert_response :success
  end

  test "should get index with search as advisor" do
    @user = users(:advisor)
    sign_in @user

    get course_offerings_path(courses(:one)), params: { search: "AAA" }
    assert_response :success
  end

  test "should not do anything as student" do
    @user = users(:one)
    sign_in @user

    get course_offerings_path(courses(:one))
    assert_redirected_to :root
    get new_course_offering_path(courses(:one))
    assert_redirected_to :root
    get edit_course_offering_path(courses(:two), offerings(:one))
    assert_redirected_to :root
    post course_offerings_path(courses(:one))
    assert_redirected_to :root
    delete course_offering_path(courses(:two), offerings(:one))
    assert_redirected_to :root
    post offerings_import_path, params: { offering_file: "file text" }
    assert_redirected_to :root
  end

  test "should update as advisor" do
    @user = users(:advisor)
    @offering = offerings(:one)
    sign_in @user
    put course_offering_path(courses(:two), @offering), params: {
      offering: { section: "YA" }
    }

    assert_equal @offering.reload.section, "YA"
    assert_redirected_to course_offerings_path(courses(:two))
  end

  test "should not update because invalid as advisor " do
    @user = users(:advisor)
    sign_in @user

    put course_offering_path(courses(:two), offerings(:one)), params: {
      offering: { section: nil }
    }

    assert_equal offerings(:one).reload.section, "D3"
  end

  test "should not put update as student" do
    @user = users(:one)
    sign_in @user

    put course_offering_path(courses(:two), offerings(:one)), params: {
      offering: { section: nil }
    }

    assert_redirected_to :root
  end

  test "should not create because invalid as advisor " do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference("Offering.count") do
      post course_offerings_path(courses(:two)), params: {
        offering: { section: nil }
      }
    end
  end

  test "should create as advisor " do
    @user = users(:advisor)
    sign_in @user

    assert_difference("Offering.count") do
      post course_offerings_path(courses(:two)), params: { offering: {
        user_id: users(:advisor).id,
        section: "D3",
        days_time_id: days_times(:two).id
      } }
    end

    assert_redirected_to course_offerings_path(courses(:two))
    assert_equal "Offering was successfully created!", flash[:notice]
  end

  test "should delete offering as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_difference("Offering.count", -1) do
      delete course_offering_path(courses(:two), offerings(:one))
    end

    assert_redirected_to course_offerings_path
    assert_equal "Offering was successfully deleted!", flash[:notice]
  end

  test "should not import offerings as advisor" do
    @user = users(:advisor)
    sign_in @user

    post offerings_import_path,
         params: { offering_file: fixture_file_upload("files/test.jpg") }

    assert_redirected_to courses_path
  end

  test "should import offerings as advisor" do
    @user = users(:advisor)
    sign_in @user

    post offerings_import_path, params: {
           offering_file: fixture_file_upload("files/test.csv", "text/csv")
         }

    assert_redirected_to courses_path
  end
end
