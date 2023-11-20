# ---------------------------------------------------------------------------------------- #
# this controller manages conversations between users and handles the broader context in   #
# which messages are exchanged (ongoing dialogue between users)                            #
# ---------------------------------------------------------------------------------------- #
class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id).includes(:messages)
  end
  def show
    @conversation = Conversation.includes(messages: :sender).find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    @message = @conversation.messages.build
  end
end

