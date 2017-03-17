# frozen_string_literal: true
require "test_helper"

class CurriculumCategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @major = majors(:one)
  end

  test "should get show as advisor" do
    @user = users(:advisor)
    sign_in @user

    get major_curriculum_category_url(@major, curriculum_categories(:one))
    assert_response :success
  end

  test "should not get show as student" do
    @user = users(:one)
    sign_in @user

    get major_curriculum_category_url(@major, curriculum_categories(:one))
    assert_redirected_to :root
  end

  test "should get new as advisor" do
    @user = users(:advisor)
    sign_in @user

    get new_major_curriculum_category_url(@major)
    assert_response :success
  end

  test "should not get new as student" do
    @user = users(:one)
    sign_in @user

    get new_major_curriculum_category_url(@major)
    assert_redirected_to :root
  end

  test "should get edit as advisor" do
    @user = users(:advisor)
    sign_in @user

    get edit_major_curriculum_category_url(@major, curriculum_categories(:one))
    assert_response :success
  end

  test "should not get edit as student" do
    @user = users(:one)
    sign_in @user

    get edit_major_curriculum_category_url(@major, curriculum_categories(:one))
    assert_redirected_to :root
  end

  test "should delete course as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_difference("CurriculumCategory.count", -1) do
      delete major_curriculum_category_url(@major, curriculum_categories(:one))
    end

    assert_redirected_to major_url(@major)
    assert_equal "Category was successfully deleted!", flash[:notice]
  end

  test "should not delete course as student" do
    @user = users(:one)
    sign_in @user

    delete major_curriculum_category_url(@major, curriculum_categories(:one))

    assert_redirected_to :root
  end

  test "should not put update as student" do
    @user = users(:one)
    sign_in @user

    put major_curriculum_category_url(@major, curriculum_categories(:one)),
        params: { curriculum_category: { category: "Math" } }

    assert_redirected_to :root
  end

  test "should create as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_difference("CurriculumCategory.count") do
      post major_curriculum_categories_url(@major),
           params: {
             curriculum_category: {
               category: "Category 1", major_id: majors(:one).id, minor: false
             }
           }
    end

    assert_redirected_to major_curriculum_category_url(
      @major, CurriculumCategory.find_by(category: "Category 1")
    )
    assert_equal "Category was successfully created!", flash[:notice]
  end

  test "should not create as advisor" do
    @user = users(:advisor)
    sign_in @user

    assert_no_difference("CurriculumCategory.count") do
      post major_curriculum_categories_url(@major),
           params: {
             curriculum_category: {
               category: "Category 1", major_id: majors(:one).id
             }
           }
    end
  end

  test "should update as advisor" do
    @user = users(:advisor)
    sign_in @user

    put major_curriculum_category_url(@major, curriculum_categories(:one)),
        params: { curriculum_category: { category: "Test" } }

    category = CurriculumCategory.find(curriculum_categories(:one).id)
    assert_equal "Test", category.category
    assert_redirected_to major_curriculum_category_url(
      @major, curriculum_categories(:one)
    )
  end

  test "should not update as advisor" do
    @user = users(:advisor)
    sign_in @user

    put major_curriculum_category_url(@major, curriculum_categories(:one)),
        params: { curriculum_category: { category: nil } }

    category = CurriculumCategory.find(curriculum_categories(:one).id)
    assert_equal "Communication Skills", category.category
  end
end
