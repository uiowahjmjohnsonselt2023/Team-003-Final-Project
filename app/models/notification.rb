class Notification < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }

  # Scope to get unread notifications
  scope :unread, -> { where(read_at: nil) }

  def mark_as_read
    unless read_at
      update(read_at: Time.current)
    end
  end
end
