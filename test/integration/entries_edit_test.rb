require 'test_helper'

class EntriesEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
    @diary = diaries(:one)
    @entry = entries(:entry_one)
  end

  test 'invalid entry edit shows error' do
    log_in_as(@user)
    get edit_user_diary_entry_path(@user,@diary,@entry)
    assert_template 'entries/edit'
    patch_via_redirect user_diary_entry_path(@user,@diary,@entry), entry: { body: nil }
    assert_not flash.empty?
    assert_select '.alert-error'
    assert_template 'entries/edit'
  end

  test 'successful entry edit' do
    log_in_as(@user)
    get edit_user_diary_entry_path(@user,@diary,@entry)
    assert_template 'entries/edit'
    patch_via_redirect user_diary_entry_path(@user,@diary,@entry), entry: { body: :foo }
    assert_not flash.empty?
    assert_select '.alert-success'
    assert_template 'entries/show'
  end

end
