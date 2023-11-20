# ---------------------------------------------------------------------------------------- #
# this controller manages conversations between users and handles the broader context in   #
# which messages are exchanged (ongoing dialogue between users)                            #
# ---------------------------------------------------------------------------------------- #
class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show]

  def index
    @conversations = Conversation.all
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    # Ensure that @messages only contains persisted Message records
    @messages = @messages.select(&:persisted?)
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end

