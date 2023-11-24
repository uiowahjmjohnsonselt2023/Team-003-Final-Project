require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    session[:user_id] = user.id
  end

  describe "GET #index" do
    it "assigns @conversations" do
      conversation = create(:conversation, sender: user)

      get :index
      expect(assigns(:conversations)).to eq([conversation])
    end
  end
end
