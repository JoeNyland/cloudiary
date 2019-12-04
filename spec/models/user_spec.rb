require 'rails_helper'

RSpec.describe User do
  let (:user) { build :user }

  it 'should be valid' do
    expect(user).to be_valid
  end

  it 'name should be present' do
    user.name = nil
    expect(user).to_not be_valid
    user.name = '    '
    expect(user).to_not be_valid
  end

  it 'email should be present' do
    user.email = nil
    expect(user).to_not be_valid
    user.email = '    '
    expect(user).to_not be_valid
  end

  it 'name should not be too long' do
    user.name = 'a' * 100
    expect(user).to_not be_valid
  end

  it 'email should not be too long' do
    user.email = 'a' * 300
    expect(user).to_not be_valid
  end

  it 'email validation should accept valid addresses' do
    %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn].each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it 'email validation should reject invalid addresses' do
    %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com].each do |valid_address|
      user.email = valid_address
      expect(user).to_not be_valid
    end
  end

  it 'email addresses should be unique' do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to_not be_valid
  end

  it 'email addresses should be stored in lower case' do
    test_email = 'TEst@EXAMple.cOm'
    user.email = test_email
    user.save
    expect(user.email).to_not eql(test_email)
    expect(user.email).to eql(test_email.downcase)
  end

  it 'password should be present (nonblank)' do
    user.password = ' ' * 6
    expect(user).to_not be_valid
  end

  it 'password should have a minimum length' do
    user.password = 'a' * 5
    expect(user).to_not be_valid
  end
end
