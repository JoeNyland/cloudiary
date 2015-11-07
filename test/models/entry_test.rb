require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  def setup
    @diary = diaries(:one)
    @entry = @diary.entries.new
  end

  test 'should not be valid if empty' do
    assert_not @entry.valid?
  end

  test 'should be valid' do
    @entry.title = 'A test diary entry'
    @entry.body = Faker::Lorem.sentence(5)
    assert @entry.valid?
  end

  test 'title must be present' do
    @entry.title = '   '
    assert_not @entry.valid?
  end

  test 'title must not be too long' do
    @entry.title = 'a' * 50
    assert_not @entry.valid?
  end

  test 'body must be present' do
    @entry.body = '   '
    assert_not @entry.valid?
  end

  test 'body must not be too long' do
    @entry.body = 'a' * 50
    assert_not @entry.valid?
  end

end
