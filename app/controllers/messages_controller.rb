class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = current_user.received_messages.includes(:sender)
  end

  def show
    @message = Message.find(params[:id])
    other_user = @message.other_party(current_user)
    @conversation = Message.where(sender_id: current_user, recipient_id: other_user)
                           .or(Message.where(sender_id: other_user, recipient_id: current_user))
  end

  def new
    @message = current_user.sent_messages.build
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