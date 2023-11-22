require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    session[:user_id] = user.id
  end
  describe "POST #create" do
    it "creates a new message" do
      conversation = create(:conversation, sender: user)
      post :create, params: { conversation_id: conversation.id, message: { body: "Hello" } }

      expect(response).to redirect_to(conversation_path(conversation))
      expect(conversation.messages.last.body).to eq("Hello")
    end
  end
end