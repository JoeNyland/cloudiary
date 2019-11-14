require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  def setup
    @entry = Entry.new
  end

  test 'should not be valid if empty' do
    assert_not @entry.valid?
  end

  test 'should be valid' do
    @entry.body = Faker::Lorem.sentences(number: 5)
    assert @entry.valid?
  end

  test 'body must be present' do
    @entry.body = '   '
    assert_not @entry.valid?
    @entry.body = Faker::Lorem.sentences(number: 5)
    assert @entry.valid?
  end

end
