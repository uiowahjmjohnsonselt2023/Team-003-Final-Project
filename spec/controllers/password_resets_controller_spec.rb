require 'rails_helper'

RSpec.describe 'Password Resets', type: :request do
  describe 'GET /password_resets/new' do
    it 'returns http success' do
      get new_password_reset_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /password_resets' do
    it 'creates a password reset record' do
    end
  end

  describe 'GET /password_resets/edit/:id' do
    it 'returns http success' do
      # Generate a password reset record and retrieve its ID
      password_reset = create(:password_reset) # Assuming you have a factory for password resets
      get edit_password_reset_path(password_reset) # Use the named route with ID
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /password_resets/update/:id' do
    it 'updates the password reset' do
      # Generate a password reset record and retrieve its ID
      password_reset = create(:password_reset) # Assuming you have a factory for password resets
      patch update_password_reset_path(password_reset), params: { password_reset: { new_password: 'new_password' } } # Use the named route with ID and parameters
      # Your expectations here
    end
  end
end
