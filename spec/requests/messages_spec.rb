require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:conversation) { create(:conversation, sender: sender, recipient: recipient) }

  before do
    post login_path, params: { session: { email: sender.email, password: sender.password } }
  end

  describe "POST /conversations/:conversation_id/messages" do
    context "with valid parameters" do
      it "creates a new Message" do
        valid_message_params = { message: { body: 'Hi there!', sender_id: sender.id, recipient_id: recipient.id } }
        expect {
          post conversation_messages_path(conversation), params: valid_message_params, xhr: true
        }.to change(Message, :count).by(1)
      end

      it "responds with JavaScript content type" do
        post conversation_messages_path(conversation), params: { message: { body: 'Hi there!', sender_id: sender.id } }, xhr: true
        expect(response.content_type).to include("text/javascript")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Message and shows errors" do
        expect {
          post conversation_messages_path(conversation), params: { message: { body: '', sender_id: sender.id } }, xhr: true
        }.not_to change(Message, :count)

        # checking why the message was not saved
        message = Message.create({ body: '', sender_id: sender.id, conversation_id: conversation.id })
        puts message.errors.full_messages
      end
    end
  end
end