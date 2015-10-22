class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  before_save { self.email = email.downcase }
end
