# frozen_string_literal: true
require "test_helper"

class MajorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user  = users(:advisor)
    @major = majors(:one)
  end

  test "should get index as advisor" do
    sign_in @user

    get majors_path
    assert_response :success
  end

  test "should get show as advisor" do
    sign_in @user

    get major_path(@major)
    assert_response :success
  end

  test "should get new as advisor" do
    sign_in @user

    get new_major_path
    assert_response :success
  end

  test "should get edit as advisor" do
    sign_in @user

    get edit_major_path(@major)
    assert_response :success
  end

  test "should not update because invalid as advisor " do
    sign_in @user

    put major_path(@major), params: { major: { major: nil } }

    assert_equal "MyString", @major.reload.major
  end

  test "should update as advisor" do
    sign_in @user

    put major_path(@major), params: { major: { major: "A new major" } }

    assert_equal "A new major", @major.reload.major
    assert_redirected_to majors_path
  end

  test "should not create because invalid as advisor " do
    sign_in @user

    assert_no_difference("Major.count") do
      post majors_path, params: { major: { major: nil } }
    end
  end

  test "should create as advisor " do
    sign_in @user

    assert_difference("Major.count") do
      post majors_path, params: { major: { major: "New major" } }
    end

    assert_redirected_to majors_path
    assert_equal "Major was successfully created", flash[:notice]
  end

  test "should delete major as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_difference("Major.count", -1) do
      delete major_path(@major)
    end

    assert_redirected_to majors_path
    assert_equal "Major was successfully destroyed", flash[:notice]
  end

  test "should not access as student" do
    @user = users(:one)
    sign_in @user

    get majors_path
    assert_redirected_to :root
    get major_path(@major)
    assert_redirected_to :root
    get new_major_path
    assert_redirected_to :root
    put major_path(@major), params: { major: { major: "A new major" } }
    assert_redirected_to :root
    post majors_path, params: { major: { major: "New major" } }
    assert_redirected_to :root
    delete major_path(@major)
    assert_redirected_to :root
    get edit_major_path(@major)
    assert_redirected_to :root
  end
end
