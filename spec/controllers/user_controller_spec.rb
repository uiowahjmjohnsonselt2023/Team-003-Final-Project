require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  describe 'PATCH #verify' do
    context 'as an admin user' do
      before do
        allow(controller).to receive(:current_user).and_return(admin)
      end

      it 'verifies the user' do
        patch :verify, params: { id: user.id }
        user.reload
        expect(user.verified).to be_truthy
        expect(response).to redirect_to(root_path)
      end
    end

    context 'as a non-admin user' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'does not verify the user' do
        patch :verify, params: { id: user.id }
        user.reload
        expect(user.verified).to be_falsey
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'PATCH #unverify' do
    context 'as an admin user' do
      before do
        allow(controller).to receive(:current_user).and_return(admin)
        user.update(verified: true)
      end

      it 'unverifies the user' do
        patch :unverify, params: { id: user.id }
        user.reload
        expect(user.verified).to be_falsey
        expect(response).to redirect_to(root_path)
      end
    end

    context 'as a non-admin user' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        user.update(verified: true)
      end

      it 'does not unverify the user' do
        patch :unverify, params: { id: user.id }
        user.reload
        expect(user.verified).to be_truthy
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
