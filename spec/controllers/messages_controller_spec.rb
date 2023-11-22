require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new message' do
        user = create(:user)
        receiver = create(:user)

        expect {
          post :create, params: { user_id: user.id, message: { receiver_id: receiver.id, body: 'Hello' } }
        }.to change(Message, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new message' do
        user = create(:user)

        expect {
          post :create, params: { user_id: user.id, message: { receiver_id: nil, body: '' } }
        }.to_not change(Message, :count)
      end
    end
  end
end
