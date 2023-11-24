class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def message_notification(user, message)
    @user = user
    @message = message
    @url  = 'http://example.com/login' # Replace with actual URL to view the message
    mail(to: @user.email, subject: 'You have a new message')
  end
end
