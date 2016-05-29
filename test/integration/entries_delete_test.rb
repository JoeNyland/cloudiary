require 'test_helper'

class EntriesDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
    @diary = diaries(:one)
    @entry = entries(:entry_one)
  end

  test 'successful entry deletion' do
    log_in_as(@user)
    assert_difference 'Entry.count',-1 do
      delete_via_redirect user_diary_entry_path(@user,@diary,@entry)
    end
    assert_template 'diaries/show'
    assert_not flash.empty?
    assert_select '.alert-success'
  end

end
