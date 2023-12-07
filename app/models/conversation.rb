class Conversation < ApplicationRecord
  belongs_to :product, optional: true
  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  def other_party(user)
    user == self.sender ? self.recipient : self.sender
  end

  # Returns the recipient of the conversation based on the sender
  def recipient_id(sender)
    sender == self.sender ? self.recipient_id : self.sender_id
  end
end
