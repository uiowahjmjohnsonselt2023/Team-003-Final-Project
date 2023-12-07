class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show]

  # GET /notifications/1
  def show
    @notification.update(read_at: Time.zone.now) if @notification.unread?
    @conversation = @notification.notifiable.conversation if @notification.notifiable.respond_to?(:conversation)

    # redirect to the conversation if it exists, or to a fallback path otherwise
    if @conversation
      redirect_to conversation_path(@conversation)
    else
      redirect_to conversations_path, alert: 'Conversation could not be found.'
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
