# ---------------------------------------------------------------------------------------- #
# this controller manages conversations between users and handles the broader context in   #
# which messages are exchanged (ongoing dialogue between users)                            #
# ---------------------------------------------------------------------------------------- #
class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def create
    recipient = User.find(params[:recipient_id])
    conversation = current_user.conversations.create!(recipient_id: recipient.id)
    redirect_to conversation_messages_path(conversation)
  end

  def destroy
    conversation = Conversation.find(params[:id])
    conversation.destroy if conversation.belongs_to?(current_user)
    redirect_to conversations_path, notice: 'Conversation deleted.'
  end
end
