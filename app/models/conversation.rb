class Conversation < ApplicationRecord
  has_many :messages
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  # returns the other party of the conversation relative to the given user
  def other_party(user)
    user == sender ? recipient : sender
  end
end
