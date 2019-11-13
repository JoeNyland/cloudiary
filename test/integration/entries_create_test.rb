require 'test_helper'

class EntriesCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
  end

  test 'invalid entry creation' do
    log_in_as(@user)
    get new_user_entry_path(@user)
    assert_no_difference 'Entry.count' do
      post user_entries_path(@user), entry: {foo: :bar}
    end
    assert_template 'entries/new'
  end

  test 'invalid entry creation shows error' do
    log_in_as(@user)
    get new_user_entry_path(@user,@diary)
    assert_no_difference 'Entry.count' do
      post user_entries_path(@user,@diary), entry: {foo: :bar}
    end
    assert_template 'entries/new'
    assert_not flash.empty?
    assert_select '.alert-danger'
  end

  test 'successful entry creation' do
    log_in_as(@user)
    get new_user_entry_path(@user,@diary)
    assert_difference 'Entry.count', 1 do
      post_via_redirect user_entries_path(@user,@diary), entry: {body: :bar}
    end
    assert_template 'entries/show'
    assert_not flash.empty?
    assert_select '.alert-success'
  end

end
