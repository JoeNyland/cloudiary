require 'rails_helper'

RSpec.describe Entry do
  let (:entry) { build :entry }

  it 'should be valid' do
    expect(entry).to be_valid
  end

  it 'body must be present' do
    entry.body = ''
    expect(entry).to_not be_valid
  end
end
