require 'test_helper'

class EntriesControllerTest < ActionController::TestCase

  def setup
    @user = users(:joe)
    @other_user = users(:user_1)
    @diary = diaries(:one)
    @entry = entries(:entry_one)
  end

  test 'should redirect get new when not logged in' do
    get :new, user_id: @user, diary_id: @diary
    assert_redirected_to login_path
  end

  test 'should allow new when logged in as correct user' do
    log_in_as(@user)
    get :new, user_id: @user, diary_id: @diary
    assert_template 'entries/new'
  end

  test 'should redirect post when not logged in' do
    post :create, user_id: @user, diary_id: @diary, entry: {title: 'test', body: 'test'*5}
    assert_redirected_to login_path
  end

  test 'should redirect get show when not logged in and redirect' do
    get :show, id: @entry, user_id: @user, diary_id: @diary
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test 'should redirect get edit when not logged in' do
    get :edit, id: @entry, user_id: @user, diary_id: @diary
    assert_redirected_to login_path
  end

  test 'should allow edit when logged in as correct user' do
    log_in_as(@user)
    get :edit, id: @entry, user_id: @user, diary_id: @diary
    assert_template 'entries/edit'
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get :edit, id: @entry, user_id: @user, diary_id: @diary
    assert flash.empty?
    assert_redirected_to root_path
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch :update, id: @entry, user_id: @user, diary_id: @diary, entry: { title: 'test', body: 'test'*5 }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'should allow update when logged in as correct user' do
    log_in_as(@user)
    patch :update, id: @entry, user_id: @user, diary_id: @diary, entry: { title: 'test', body: 'test'*5 }
    assert_not flash.empty?
    assert_redirected_to user_diary_entry_path
  end

end
