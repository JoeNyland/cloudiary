class Entry < ActiveRecord::Base
  belongs_to :diary
  validates :title, presence: true, length: { maximum: 32 }
  validates :body, presence: true, length: { minimum: 1 }
end
