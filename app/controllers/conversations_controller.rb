# ---------------------------------------------------------------------------------------- #
# this controller manages conversations between users and handles the broader context in   #
# which messages are exchanged (ongoing dialogue between users)                            #
# ---------------------------------------------------------------------------------------- #
class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def index
    @conversations = current_user.conversations
  end

  def show
    @message = Message.new
  end

  def create
    recipient = User.find(params[:recipient_id])
    @conversation = Conversation.find_or_create_by(sender_id: current_user.id, recipient_id: recipient.id)
    redirect_to conversation_messages_path(@conversation)
  end

  def destroy
    @conversation = current_user.conversations.find_by(id: params[:id])
    if @conversation.present?
      @conversation.destroy
      redirect_to conversations_path, notice: 'Conversation deleted.'
    else
      redirect_to conversations_path, alert: 'Conversation not found.'
    end
  end

  private

  def set_conversation
    @conversation = current_user.conversations.find_by(id: params[:id])
    redirect_to conversations_path, alert: "Conversation not found." unless @conversation
  end
end

