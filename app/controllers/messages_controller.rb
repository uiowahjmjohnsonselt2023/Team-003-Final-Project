class MessagesController < ApplicationController
  def index
    @messages = Message.where(recipient: current_user)
  end

  def new
    @message = Message.new
    @message.recipient_id = params[:seller_id] if params[:seller_id].present?
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      redirect_to messages_path, notice: 'Message sent successfully.'
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end