class Notification < ApplicationRecord
  belongs_to :recipient
  belongs_to :actor
  belongs_to :notifiable, polymorphic: true
end
