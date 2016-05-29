class Entry < ActiveRecord::Base
  belongs_to :diary
  validates :body, presence: true, length: { minimum: 1 }
end
