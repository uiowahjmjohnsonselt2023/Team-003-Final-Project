class MessagesController < ApplicationController
  before_action :set_user

  def create
    @message = @user.sent_messages.build(message_params)

    if @message.save
      notify_receiver(@message)
      render json: { status: 'Message sent successfully' }, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def message_params
    params.require(:message).permit(:receiver_id, :body)
  end

  def notify_receiver(message)
    # Implement notification logic here
    # For example, send an email or a push notification to the receiver
  end
end

