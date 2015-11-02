class Diary < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: { maximum: 32 }
end
