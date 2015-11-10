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

  test 'should redirect get show when not logged in and redirect' do
    get :show, id: @entry, user_id: @user, diary_id: @diary
    assert_redirected_to login_path
    assert_not flash.empty?
  end

end
