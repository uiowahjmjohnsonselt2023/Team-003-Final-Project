require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      it "logs in the user and redirects to root path" do
        user = create(:user)

        post :create, params: { username: user.username, password: user.password }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(profile_path)
        expect(flash[:notice]).to eq('Logged in successfully.')
      end
      it 'creates a new user with verification token' do
        user = create(:user)
        expect(user.verification_token).to be_present
        expect(user.verified).to be false
      end
    end

    context "with invalid credentials" do
      it "does not log in the user and re-renders the new template" do
        post :create, params: { username: 'wrong', password: 'user' }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
        expect(flash.now[:alert]).to eq('Username or password is invalid')
      end
    end
  end

  describe "DELETE #destroy" do
    it "logs out the user and redirects to login page" do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
      expect(flash[:notice]).to eq("Logged out!")
    end
  end
end
