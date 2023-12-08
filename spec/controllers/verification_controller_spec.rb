require 'rails_helper'

RSpec.describe VerificationController, type: :controller do
  describe 'GET #verify' do
    let(:user) { create(:user, verification_token: 'valid_token') }
    let(:user_invalid_token) { create(:user, verification_token: 'valid_token') }
    it 'verifies the user and redirects to login' do
      get :verify, params: { id: user.id, token: user.verification_token }
      
      expect(response).to redirect_to(login_path)
    end
    it 'redirects to root when invalid token' do 
      get :verify, params: {id: user_invalid_token.id, token: 'invalid_token'}
      expect(response).to redirect_to(root_path)
    end
  end
end
