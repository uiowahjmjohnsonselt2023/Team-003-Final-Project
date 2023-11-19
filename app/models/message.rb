class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates :body, presence: true

  # returns the other party involved in the message
  def other_party(user)
  sender == user ? recipient : sender
  end
end
