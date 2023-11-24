module ApplicationHelper
  def notification_action(notification)
    "#{notification.actor.username} #{notification.action}"
  end
end
