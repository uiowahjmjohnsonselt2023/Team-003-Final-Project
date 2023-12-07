class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :user, presence: true
  validates :body, presence: true
end
