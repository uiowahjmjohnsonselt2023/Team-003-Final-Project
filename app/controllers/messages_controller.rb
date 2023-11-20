# ---------------------------------------------------------------------------------------- #
# this controller manages "individual" messages and focuses on the creation and            #
# manipulation of individual messages within a conversation it doesn't concern             #
# itself with the overall conversation's context but rather with discrete message events   #
# ---------------------------------------------------------------------------------------- #
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.js
        format.html { redirect_to conversation_path(@conversation) } # Handles the standard HTTP request
      else
        format.js { render 'error' } # You might need to create an error.js.erb if you want custom handling
        format.html { redirect_to conversation_path(@conversation), alert: 'Error sending message.' } # Handles the standard HTTP request
      end
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