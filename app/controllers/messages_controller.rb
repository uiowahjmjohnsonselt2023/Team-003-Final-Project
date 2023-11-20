# ---------------------------------------------------------------------------------------- #
# this controller manages "individual" messages and focuses on the creation and            #
# manipulation of individual messages within a conversation it doesn't concern             #
# itself with the overall conversation's context but rather with discrete message events   #
# ---------------------------------------------------------------------------------------- #
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def index
    @messages = @conversation.messages
    @message = @conversation.messages.new
  end

  def create
    message = @conversation.messages.new(message_params)
    message.user = current_user
    if message.save
      # Broadcast to the recipient using ActionCable
      MessagesChannel.broadcast_to(@conversation, message.as_json)
      head :ok
    else
      redirect_to conversation_messages_path(@conversation), alert: 'Error sending message.'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
    redirect_to(root_path, alert: "You don't have permission to view this conversation.") unless @conversation.participates?(current_user)
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
