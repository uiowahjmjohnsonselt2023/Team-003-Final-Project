class MessagesController < ApplicationController
  before_action :set_conversation, only: [:create]
  before_action :authenticate_user

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    recipient = @conversation.other_party(current_user)

    if @message.save
      notification = Notification.new(
        recipient: recipient,
        actor: current_user,
        action: 'sent you a message',
        notifiable: @message
      )

      if notification.save
        # broadcast the notification
        NotificationChannel.broadcast_to(
          recipient,
          {
            title: 'New Message',
            content: "#{current_user.username} sent you a message"
          }
        )
        redirect_to conversation_path(@conversation), notice: 'Message sent successfully'
      else
        render 'conversations/show', alert: 'Unable to send message'
      end
    else
      render 'conversations/show', alert: 'Unable to send message'
    end
  end



  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def authenticate_user
    redirect_to login_path unless current_user
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def notification_action(notification)
    "#{notification.actor.username} #{notification.action}"
  end

  def self.notify_receiver(message)
    recipient = User.find(message.conversation.recipient_id)
    UserMailer.message_notification(recipient, message).deliver_later
  end
end

