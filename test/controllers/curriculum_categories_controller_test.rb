require 'test_helper'

class CurriculumCategoriesControllerTest < ActionController::TestCase
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

  test 'should not get new as student' do
    @user = users(:one)
    sign_in @user

    get :new
    assert_redirected_to :root
  end

  test 'should get edit as advisor' do
    @user = users(:advisor)
    sign_in @user

    get :edit, params: { id: curriculum_categories(:one).id }
    assert_response :success
  end

  test 'should not get edit as student' do
    @user = users(:one)
    sign_in @user

    get :edit, params: { id: curriculum_categories(:one).id }
    assert_redirected_to :root
  end

  test 'should delete course as advisor' do
    @user = users(:advisor)
    sign_in @user

    assert_difference('CurriculumCategory.count', -1) do
      delete :destroy, params: { id: curriculum_categories(:one).id }
    end

    assert_redirected_to :curriculum_categories
    assert_equal curriculum_categories(:one).category +
                 ' successfully deleted!',
                 flash[:notice]
  end

  test 'should not delete course as student' do
    @user = users(:one)
    sign_in @user

    delete :destroy, params: { id: curriculum_categories(:one).id }

    assert_redirected_to :root
  end

  test 'should not put update as student' do
    @user = users(:one)
    sign_in @user

    put :update,
        params: {
          id: curriculum_categories(:one).id,
          curriculum_category: { category: 'Math' }
        }
    assert_redirected_to :root
  end

  test 'should not update because invalid as advisor ' do
    @user = users(:advisor)
    sign_in @user

    put :update,
        params: {
          id: curriculum_categories(:one).id,
          curriculum_category: { category: 'Math' }
        }

    assert_equal 'Communication Skills',
                 CurriculumCategory.find(
                   curriculum_categories(:one).id
                 ).category
  end
end
