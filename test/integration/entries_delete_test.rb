require 'test_helper'

class EntriesDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
    @entry = entries(:entry_one)
  end

  test 'successful entry deletion' do
    log_in_as(@user)
    assert_difference 'Entry.count',-1 do
      delete user_entry_path(@user,@entry)
      follow_redirect!
    end
    assert_template 'entries/index'
    assert_not flash.empty?
    assert_select '.alert-success'
  end

end
