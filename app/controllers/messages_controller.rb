class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = current_user.received_messages.includes(:sender)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    @new_message = @conversation.messages.build
  end

  def new
    @message = current_user.sent_messages.build
    @message.recipient_id = params[:seller_id] if params[:seller_id].present?
  end

  def create
    # find conversation between the two users or create a new one
    @conversation = Conversation.between(current_user.id, message_params[:recipient_id]).first_or_create do |conversation|
      conversation.sender_id = current_user.id
      conversation.recipient_id = message_params[:recipient_id]
    end

    # build a new message associated with the found/created conversation
    @message = @conversation.messages.build(message_params.merge(sender_id: current_user.id))

    if @message.save
      # if the message saves successfully, redirect to the conversation show page
      redirect_to conversation_path(@conversation), notice: 'Message sent successfully.'
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :body)
  end
end