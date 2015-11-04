require 'test_helper'

class DiariesControllerTest < ActionController::TestCase
  def setup
    @user = users(:joe)
    @other_user = users(:user_1)
  end

  test 'should redirect get new when not logged in' do
    get :new, user_id: @user
    assert_redirected_to login_url
  end

  test 'should redirect edit when not logged in' do
    # get :edit, user_id: @user
    # assert_not flash.empty?
    # assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    # patch :update, id: @user, user: { name: @user.name, email: @user.email }
    # assert_not flash.empty?
    # assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong user' do
    # log_in_as(@other_user)
    # get :edit, id: @user
    # assert flash.empty?
    # assert_redirected_to root_url
  end
end
