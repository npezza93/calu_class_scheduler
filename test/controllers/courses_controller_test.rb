# frozen_string_literal: true
require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user   = users(:advisor)
    @course = courses(:four)
  end

  test "should get new as advisor" do
    sign_in @user

    get new_course_path
    assert_response :success
  end

  test "should not create because invalid as advisor " do
    sign_in @user

    assert_no_difference("Course.count") do
      post courses_path, params: { course: { title: "CSC" } }
    end
  end

  test "should create as advisor " do
    sign_in @user

    assert_difference("Course.count") do
      post courses_path, params: {
        course: { title: "Course 1", subject: "CCC", course: 123 }
      }
    end

    assert_redirected_to Course.find_by(title: "Course 1", subject: "CCC")
    assert_equal "Course was successfully created!", flash[:notice]
  end

  test "should get index as advisor" do
    sign_in @user

    get courses_path
    assert_response :success
  end

  test "should get index with letter as advisor" do
    sign_in @user

    get courses_path(letter: "D")
    assert_response :success
  end

  test "should get index as json" do
    sign_in @user

    get courses_path(format: :json)
    assert_response :success
  end

  test "should get course as advisor" do
    sign_in @user

    get course_path(@course)
    assert_response :success
  end

  test "should get edit as advisor" do
    sign_in @user

    get edit_course_path(@course)
    assert_response :success
  end

  test "should not update because invalid as advisor " do
    sign_in @user

    put course_path(@course), params: { course: { title: nil } }

    assert_equal "Course 4", @course.reload.title
  end

  test "should update as advisor" do
    sign_in @user

    put course_path(@course), params: { course: { title: "A course" } }

    assert_equal "A course", @course.reload.title
    assert_redirected_to @course
  end

  test "should delete course as advisor" do
    sign_in @user

    assert_difference("Course.count", -1) do
      delete course_path(@course)
    end

    assert_redirected_to courses_path
    assert_equal "Course was successfully destroyed.", flash[:notice]
  end

  test "should not access courses as student" do
    @user = users(:one)
    sign_in @user

    get new_course_path
    assert_redirected_to root_url
    post courses_path, params: { course: { title: "CSC" } }
    assert_redirected_to root_url
    get courses_path
    assert_redirected_to root_url
    get course_path(@course)
    assert_redirected_to root_url
    get edit_course_path(@course)
    assert_redirected_to root_url
    put course_path(@course), params: { course: { title: "CSC" } }
    assert_redirected_to root_url
    delete course_path(@course)
    assert_redirected_to root_url
  end
end
