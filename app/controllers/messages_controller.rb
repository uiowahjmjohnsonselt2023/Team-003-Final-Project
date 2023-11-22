class MessagesController < ApplicationController
  before_action :set_conversation, only: [:create]
  before_action :authenticate_user

  def create
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      self.class.notify_receiver(@message)
      Notification.create(
        recipient: @message.receiver,
        actor: current_user,
        action: 'sent you a message',
        notifiable: @message
      )
      redirect_to conversation_path(@conversation), notice: 'Message sent successfully'
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

  def self.notify_receiver(message)
    recipient = User.find(message.conversation.recipient_id)
    UserMailer.message_notification(recipient, message).deliver_later
  end
end

