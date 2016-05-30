class Diary < ActiveRecord::Base
  belongs_to :user
  has_many :entries, dependent: :destroy
  validates :title, presence: true, length: { maximum: 32 }
end
