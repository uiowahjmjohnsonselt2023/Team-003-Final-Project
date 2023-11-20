# ---------------------------------------------------------------------------------------- #
# this controller manages "individual" messages and focuses on the creation and            #
# manipulation of individual messages within a conversation it doesn't concern             #
# itself with the overall conversation's context but rather with discrete message events   #
# ---------------------------------------------------------------------------------------- #
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      @messages = @conversation.messages
      render 'conversations/show'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
