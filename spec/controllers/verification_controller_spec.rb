require 'rails_helper'

RSpec.describe VerificationController, type: :controller do
  describe 'GET #verify' do
    let(:user) { create(:user, verification_token: 'valid_token') }

    it 'verifies the user and redirects to login' do
      get :verify, params: { id: user.id, token: user.verification_token }
      before_user = User.find_by(id: user.id)
      puts "Before reload - User: #{before_user.inspect}"
      

      reloaded_user = User.find_by(id: user.id)
      puts "After reload - User: #{reloaded_user.inspect}"
      expect(user.verified).to be true
      expect(user.verification_token).to be_nil
      expect(response).to redirect_to(login_path)
    end
  end
end
