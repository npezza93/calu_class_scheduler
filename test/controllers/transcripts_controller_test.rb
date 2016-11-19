require 'test_helper'

class TranscriptsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test 'should get index as student' do
    @user = users(:one)
    sign_in @user

    get :index
    assert_response :success
  end

  test 'should not get index as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :index
    assert_redirected_to :root
  end

  test 'should not create because invalid as student ' do
    @user = users(:one)
    sign_in @user

    assert_no_difference('Transcript.count') do
      post :create, params: { transcript: { course_id: nil } }
    end
  end

  test 'should create as student ' do
    @user = users(:one)
    sign_in @user

    assert_difference('Transcript.count') do
      post :create, params: {
        transcript: { course_id: courses(:one).id, grade_c: 'A' }
      }
    end

    assert_redirected_to :transcripts
    assert_equal courses(:one).title + ' added!', flash[:notice]
  end

  test 'should not post create as advisor' do
    @user = users(:advisor)
    sign_in @user

    post :create, params: { transcript: { course_id: courses(:one).id } }
    assert_redirected_to :root
  end

  test 'should delete course as student' do
    @user = users(:one)
    sign_in @user

    assert_difference('Transcript.count', -1) do
      delete :destroy, params: { id: transcripts(:one).id }
    end

    assert_redirected_to :transcripts
    assert_equal courses(:two).title + ' removed!',
                 flash[:notice]
  end

  test 'should not delete course as advisor' do
    @user = users(:advisor)
    sign_in @user

    delete :destroy, params: { id: transcripts(:one).id }

    assert_redirected_to :root
  end

  test 'should import as student' do
    @user = users(:one)
    sign_in @user

    post :import, params: { 'Transcript' => nil }
    assert_redirected_to :transcripts
  end

  test 'should not import as advisor' do
    @user = users(:advisor)
    sign_in @user

    post :import
    assert_redirected_to :root
  end
end
