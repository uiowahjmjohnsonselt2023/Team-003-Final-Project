class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User'
  validates :body, presence: true

  # callback to set message as unread upon creation
  after_create_commit :set_as_unread

  private

  def set_as_unread
    update(read: false)
  end

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
