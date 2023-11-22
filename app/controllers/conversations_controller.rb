class ConversationsController < ApplicationController
  before_action :authenticate_user
  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
  end

  private

  def authenticate_user
    # Define authentication logic
  end
end