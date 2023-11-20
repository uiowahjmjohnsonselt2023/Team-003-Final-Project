class MessagesChannel < ApplicationCable::Channel
  def subscribed
    conversation = current_user.conversations.find(params[:conversation_id])
    stream_for conversation
  end

  def unsubscribed
  end
end

