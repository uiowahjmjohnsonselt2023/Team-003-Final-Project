# spec/controllers/password_resets_controller_spec.rb
require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid username and email' do
      it 'generates a password reset token and redirects to root path' do
        post :create, params: { password_reset: { username: user.username, email: user.email } }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to include('Password reset successfully.')
      end
    end

    context 'with invalid username or email' do
      it 'renders the new template with an error message' do
        post :create, params: { password_reset: { username: 'wrong_username', email: user.email } }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to include('Invalid username or email.')
      end
    end

    context 'with missing username or email' do
      it 'renders the new template with an error message' do
        post :create, params: { password_reset: { username: '', email: '' } }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to include('Username and email are required fields.')
      end
    end
  end
end
