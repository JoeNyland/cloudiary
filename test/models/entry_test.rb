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
    @entry.body = Faker::Lorem.sentences(5)
    assert @entry.valid?
  end

  test 'body must be present' do
    @entry.body = '   '
    assert_not @entry.valid?
    @entry.body = Faker::Lorem.sentences(5)
    assert @entry.valid?
  end

end
