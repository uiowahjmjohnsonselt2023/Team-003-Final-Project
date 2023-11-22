class ConversationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_conversation, only: [:show, :destroy]
  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end

  def show
    @conversation = Conversation.includes(:product).find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path, notice: 'Conversation was successfully deleted.'
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def authenticate_user
    redirect_to login_path unless current_user
  end
end