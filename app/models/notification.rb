class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  def redirect_path
   conversation_path(notifiable.conversation)
  end

  # Scope to get unread notifications
  scope :unread, -> { where(read_at: nil) }

  def unread?
    read_at.nil?
  end

  def mark_as_read
    unless read_at
      update(read_at: Time.current)
    end
  end
end
