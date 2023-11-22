class MessagesController < ApplicationController
  before_action :set_sender

  def create
    @message = Message.new(message_params.merge(sender_id: @sender.id))

    if @message.save
      notify_receiver(@message)
      render json: { status: 'Message sent successfully' }, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def set_sender
    @sender = User.find(params[:user_id])
  end

  def message_params
    params.require(:message).permit(:receiver_id, :body)
  end

  def notify_receiver(message)
  end
end

