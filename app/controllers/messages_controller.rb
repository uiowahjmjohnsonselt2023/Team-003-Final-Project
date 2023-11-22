# ---------------------------------------------------------------------------------------- #
# this controller manages "individual" messages and focuses on the creation and            #
# manipulation of individual messages within a conversation it doesn't concern             #
# itself with the overall conversation's context but rather with discrete message events   #
# ---------------------------------------------------------------------------------------- #
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user
    @message.recipient = @conversation.other_party(current_user)

    respond_to do |format|
      if @message.save
        format.js
        format.html { redirect_to conversation_path(@conversation) }
      else
        format.js { render 'error', status: :unprocessable_entity }
        format.html { redirect_to conversation_path(@conversation), alert: 'Error sending message.' }
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :sender_id)
  end
end