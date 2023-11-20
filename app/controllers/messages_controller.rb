# ---------------------------------------------------------------------------------------- #
# this controller manages "individual" messages and focuses on the creation and            #
# manipulation of individual messages within a conversation it doesn't concern             #
# itself with the overall conversation's context but rather with discrete message events   #
# ---------------------------------------------------------------------------------------- #
class MessagesController < ApplicationController
  before_action :authenticate_user!

  # creating a new message within a conversation
  def create
    @conversation = Conversation.find(params[:message][:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user

    if @message.save
      flash[:success] = 'Message sent successfully'
      redirect_to conversation_path(@conversation)
    else
      render 'conversations/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end
end