require 'test_helper'

class EntriesEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
    @entry = entries(:entry_one)
  end

  test 'invalid entry edit shows error' do
    log_in_as(@user)
    get edit_user_entry_path(@user,@entry)
    assert_template 'entries/edit'
    patch user_entry_path(@user,@entry), params: { entry: { body: nil } }
    assert_not flash.empty?
    assert_select '.alert-error'
    assert_template 'entries/edit'
  end

  test 'successful entry edit' do
    log_in_as(@user)
    get edit_user_entry_path(@user,@entry)
    assert_template 'entries/edit'
    patch user_entry_path(@user,@entry), params: { entry: { body: :foo } }
    follow_redirect!
    assert_not flash.empty?
    assert_select '.alert-success'
    assert_template 'entries/show'
  end

end
