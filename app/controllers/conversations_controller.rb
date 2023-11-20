# ---------------------------------------------------------------------------------------- #
# this controller manages conversations between users and handles the broader context in   #
# which messages are exchanged (ongoing dialogue between users)                            #
# ---------------------------------------------------------------------------------------- #
class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def index
    # get conversations and ensure no duplicates by the recipient_id or sender_id
    @conversations = Conversation.where(sender_id: current_user.id)
                                 .or(Conversation.where(recipient_id: current_user.id))
                                 .distinct
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @message = Message.new  # Make sure @message is initialized for the form
  end

  def create
    recipient = User.find(params[:recipient_id])
    @conversation = Conversation.find_or_create_by(sender_id: current_user.id, recipient_id: recipient.id)
    redirect_to conversation_messages_path(@conversation)
  end

  def destroy
    if @conversation.present?
      @conversation.destroy
      respond_to do |format|
        format.html { redirect_to conversations_path, notice: 'Conversation was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      redirect_to conversations_path, alert: 'Conversation could not be found.'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id], sender_id: current_user.id) ||
      Conversation.find_by(id: params[:id], recipient_id: current_user.id)
  end
end

