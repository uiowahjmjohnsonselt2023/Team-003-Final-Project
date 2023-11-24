require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipient) { FactoryBot.create(:user) }
  let(:conversation) { FactoryBot.create(:conversation, sender: user, recipient: recipient) }

  before do
    session[:user_id] = user.id
  end

  describe "POST #create" do
    let(:message_params) { { body: "Hello" } }

    it "creates a new message and a notification" do
      allow(NotificationChannel).to receive(:broadcast_to)

      post :create, params: { conversation_id: conversation.id, message: message_params }

      expect(response).to redirect_to(conversation_path(conversation))
      last_message = Message.last
      expect(last_message.body).to eq("Hello")

      # Directly check for the notification
      notification = Notification.find_by(notifiable: last_message)
      if notification.nil?
        puts "No notification created. Last message: #{last_message.inspect}"
        # Optionally print out the last message errors if creation failed
        puts "Message errors: #{last_message.errors.full_messages.join(", ")}" if last_message.errors.any?
      end

      expect(notification).not_to be_nil
    end
  end
end
