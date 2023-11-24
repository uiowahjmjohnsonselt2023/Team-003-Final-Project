require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views
  describe 'POST #create' do
    context 'with valid credentials' do
      let(:user) { create(:user, username: 'johndoe', password: 'password') }

      before do
        post :create, params: { username: user.username, password: 'password' }
      end

      it 'sets the user_id in the session' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to the user profile path' do
        expect(response).to redirect_to(profile_path)
      end

      it 'sets a notice flash message' do
        expect(flash[:notice]).to eq('Logged in successfully.')
      end
    end

    context 'with invalid credentials' do
      before do
        post :create, params: { username: 'wrong', password: 'user' }
      end

      it 'does not set the user_id in the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'sets an alert flash message' do
        expect(flash.now[:alert]).to eq('Username or password is invalid')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = 1
      delete :destroy
    end

    it 'clears the user_id from the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the login page' do
      expect(response).to redirect_to(login_path)
    end

    it 'sets a notice flash message' do
      expect(flash[:notice]).to eq('Logged out!')
    end
  end
end