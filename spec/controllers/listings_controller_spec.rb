require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }

    it 'creates a listing' do
      allow(controller).to receive(:current_user).and_return(user)

      listing_params = { title: 'My listing', description: 'This is my listing', price: 10.00, condition: 'New', quantity: 1, user_id: user.id}

      post :create, params: { listing: listing_params }

      expect(response).to redirect_to(listings_path)
      expect(flash[:notice]).to eq('Listing added!')
    end

    it 'does not create a listing with invalid params' do
      allow(controller).to receive(:current_user).and_return(user)

      invalid_listing_params = { title: 'My listing', description: 'This is my listing', price: 10.00, user_id: user.id }

      post :create, params: { listing: invalid_listing_params }

      expect(response).to render_template(:new)
    end
  end
  describe 'New listing' do
    let(:user) { FactoryBot.create(:user) }
    it 'should render the new listing page' do

      allow(controller).to receive(:current_user).and_return(user)
      get :new
      expect(response).to render_template(:new)
    end
  end
  describe 'New listing, not signed in' do
    it 'should not render the new listing page if no signed in' do
      get :new
      expect(response).to redirect_to(login_path)
    end
  end


end