require 'test_helper'

class DiaryTest < ActiveSupport::TestCase

  def setup
    @user = users(:joe)
    @diary = @user.diaries.new(title: 'My test diary')
  end

  test 'should be valid' do
    assert @diary.valid?
  end

  test 'title must be present' do
    @diary.title = '   '
    assert_not @diary.valid?
  end

  test 'title must not be too long' do
    @diary.title = 'a' * 50
    assert_not @diary.valid?
  end

end
