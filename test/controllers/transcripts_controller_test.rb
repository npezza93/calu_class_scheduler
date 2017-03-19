# frozen_string_literal: true
require "test_helper"

class TranscriptsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user   = users(:one)
    @course = courses(:one)
  end

  test "should get index as student" do
    sign_in @user

    get transcripts_path
    assert_response :success
  end

  test "should not create because invalid as student " do
    sign_in @user

    assert_no_difference("Transcript.count") do
      post transcripts_path, params: { transcript: { course_id: nil } }
    end
  end

  test "should create as student" do
    sign_in @user

    assert_difference("Transcript.count") do
      post transcripts_path, params: {
        transcript: { course_id: @course.id, grade_c: "A" }
      }
    end

    assert_redirected_to transcripts_path
    assert_equal "Course added to transcript", flash[:notice]
  end

  test "should delete course as student" do
    sign_in @user

    assert_difference("Transcript.count", -1) do
      delete transcript_path(transcripts(:one))
    end

    assert_redirected_to transcripts_path
    assert_equal "Course removed from transcript", flash[:notice]
  end

  test "should get new as student" do
    sign_in @user

    get new_transcript_path
    assert_response :success
  end

  test "should not access as advisor" do
    @user = users(:advisor)
    sign_in @user

    get transcripts_path
    assert_redirected_to :root
    get new_transcript_path
    assert_redirected_to :root
    delete transcript_path(transcripts(:one))
    assert_redirected_to :root
    post transcripts_path, params: { transcript: { course_id: @course.id } }
    assert_redirected_to :root
  end
end
