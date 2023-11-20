class MessagesController < ApplicationController
  before_action :authenticate_user!

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