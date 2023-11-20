class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
  has_many :messages, dependent: :destroy

  # returns the other party of the conversation relative to the given user
  def other_party(user)
    user == sender ? recipient : sender
  end

  # scope to get the conversation between two users
  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end
end
