require 'test_helper'

class DiariesControllerTest < ActionController::TestCase
  def setup
    @user = users(:joe)
    @other_user = users(:user_1)
    @diary = diaries(:diary_1)
  end

  test 'should redirect get index when not logged in' do
    get :index, user_id: @user
    assert_redirected_to login_url
  end

  test 'should redirect get new when not logged in' do
    get :new, user_id: @user
    assert_redirected_to login_url
  end

  test 'should redirect get show when not logged in' do
    get :show, id: @diary, user_id: @user
    assert_redirected_to login_url
    assert_not flash.empty?
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

  test 'should not redirect get index when logged in' do
    log_in_as @user
    get :index, user_id: @user
    assert_template 'diaries/index'
    assert flash.empty?
  end

  test 'should not redirect get new when logged in' do
    log_in_as @user
    get :new, user_id: @user
    assert_template 'diaries/new'
    assert flash.empty?
  end

  test 'should not redirect get show when logged in' do
    log_in_as @user
    get :show, id: @diary, user_id: @user
    assert_template 'diaries/show'
    assert flash.empty?
  end
end
