require 'test_helper'

class DiariesCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
  end

  test 'invalid diary creation' do
    log_in_as(@user)
    get new_user_diary_path(@user)
    assert_no_difference 'Diary.count' do
      post user_diaries_path(@user, diary: {foo: :bar})
    end
    assert_template 'diaries/new'
  end

  test 'invalid diary creation shows error' do
    log_in_as(@user)
    get new_user_diary_path(@user)
    assert_no_difference 'Diary.count' do
      post user_diaries_path(@user, diary: {foo: :bar})
    end
    assert_template 'diaries/new'
    assert_not flash.empty?
    assert_select '.alert-danger'
  end

  test 'successful diary creation' do
    log_in_as(@user)
    get new_user_diary_path(@user)
    assert_difference 'Diary.count', 1 do
      post_via_redirect user_diaries_path(@user, diary: {title: :bar})
    end
    assert_template 'diaries/show'
    assert_not flash.empty?
    assert_select '.alert-info'
  end

end
