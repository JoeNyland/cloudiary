require 'test_helper'

class DiariesDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joe)
    @diary = diaries(:one)
  end

  test 'successful diary deletion' do
    log_in_as(@user)
    assert_difference 'Diary.count',-1 do
      delete_via_redirect user_diary_path(@user,@diary)
    end
    assert_template 'diaries/index'
    assert_not flash.empty?
    assert_select '.alert-success'
  end

end
