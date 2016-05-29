require 'test_helper'

class DiariesEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
    @diary = diaries(:one)
  end

  test 'invalid diary edit shows error' do
    log_in_as(@user)
    get edit_user_diary_path(@user,@diary)
    assert_template 'diaries/edit'
    patch_via_redirect user_diary_path(@user,@diary), diary: { title: nil }
    assert_not flash.empty?
    assert_select '.alert-error'
    assert_template 'diaries/edit'
  end

  test 'successful diary edit' do
    log_in_as(@user)
    get edit_user_diary_path(@user,@diary)
    assert_template 'diaries/edit'
    patch_via_redirect user_diary_path(@user,@diary), diary: { title: 'foo' }
    assert_not flash.empty?
    assert_select '.alert-success'
    assert_template 'diaries/show'
  end

end
