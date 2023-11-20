class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    MessagesChannel.broadcast_to(
      message.conversation,
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    )
  end
end
