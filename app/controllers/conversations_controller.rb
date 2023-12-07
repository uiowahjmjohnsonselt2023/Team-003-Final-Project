class ConversationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_conversation, only: [:show, :destroy]
  def index
    @conversations = Conversation.where(sender_id: session[:user_id]).or(Conversation.where(recipient_id: session[:user_id]))
  end

  def show
    @conversation = Conversation.includes(product: { image_attachment: :blob }).find(params[:id])
    @product = @conversation.product
    @messages = @conversation.messages.order(created_at: :asc)
    @other_user = @conversation.other_party(current_user)
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