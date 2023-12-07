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

  def create_for_user
    recipient = User.find(params[:user_id])
    product = Product.find_by(id: params[:product_id])

    @conversation = if product
                      Conversation.find_or_create_by(product: product, sender: current_user, recipient: recipient)
                    else
                      Conversation.find_or_create_by(sender: current_user, recipient: recipient) do |conversation|
                        conversation.product = nil
                      end
                    end

    if @conversation.persisted?
      redirect_to conversation_path(@conversation)
    end
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