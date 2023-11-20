class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @conversation = Conversation.includes(messages: :sender).find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    @message = @conversation.messages.build
  end
end

