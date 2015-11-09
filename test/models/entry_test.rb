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
    @entry.body = Faker::Lorem.sentences(5)
    assert @entry.valid?
  end

  test 'title must be present' do
    @entry.title = '   '
    @entry.body = Faker::Lorem.sentences(5)
    assert_not @entry.valid?
  end

  test 'title must not be too long' do
    @entry.title = 'a' * 50
    @entry.body = Faker::Lorem.sentences(5)
    assert_not @entry.valid?
  end

  test 'body must be present' do
    @entry.title = 'a' * 30
    @entry.body = '   '
    assert_not @entry.valid?
    @entry.body = Faker::Lorem.sentences(5)
    assert @entry.valid?
  end

end
