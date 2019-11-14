require 'test_helper'

class EntriesControllerTest < ActionController::TestCase

  def setup
    @user = users(:joe)
    @other_user = users(:user_1)
    @entry = entries(:entry_one)
  end

  test 'should redirect get new when not logged in' do
    get :new, params: { user_id: @user }
    assert_redirected_to login_path
  end

  test 'should allow new when logged in as correct user' do
    log_in_as(@user)
    get :new, params: { user_id: @user }
    assert_template 'entries/new'
  end

  test 'should redirect post when not logged in' do
    post :create, params: { user_id: @user, entry: {title: 'test', body: 'test'*5} }
    assert_redirected_to login_path
  end

  test 'should redirect get show when not logged in and redirect' do
    get :show, params: { id: @entry, user_id: @user }
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test 'should redirect get edit when not logged in' do
    get :edit, params: { id: @entry, user_id: @user }
    assert_redirected_to login_path
  end

  test 'should allow edit when logged in as correct user' do
    log_in_as(@user)
    get :edit, params: { id: @entry, user_id: @user }
    assert_template 'entries/edit'
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get :edit, params: { id: @entry, user_id: @user }
    assert flash.empty?
    assert_redirected_to root_path
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch :update, params: { id: @entry, user_id: @user, entry: { title: 'test', body: 'test'*5 } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'should allow update when logged in as correct user' do
    log_in_as(@user)
    patch :update, params: { id: @entry, user_id: @user, entry: { body: 'test'*5 } }
    assert_not flash.empty?
    assert_redirected_to user_entry_path
  end

end
