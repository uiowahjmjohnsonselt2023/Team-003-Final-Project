require 'rails_helper'
require 'spec_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'POST #create_bid' do
    let(:product) { create(:product) }

    context 'when auction is active' do
      it 'creates a new bid' do
        # Create a product with explicit values
        product = Product.create(
          title: 'Example Product',
          user: create(:user), # Assuming you have a user factory
          category: create(:category), # Assuming you have a category factory
          auction_start_time: 1.hour.ago,
          auction_end_time: 1.hour.from_now
        )

        post :create_bid, params: { id: product.id, bid: { amount: 50 } }
        expect(response).to redirect_to(product)
        expect(flash[:notice]).to be_present
      end
    end
  end
  describe 'POST #create_bid' do
    let(:product) { create(:product) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    it 'allows multiple users to bid on a product' do
      # Sign in user1
      login user1

      # User1 places a bid
      post :create_bid, params: { id: product.id, bid: { amount: 50 } }
      expect(response).to redirect_to(product)
      expect(flash[:notice]).to be_present

      # Sign out user1 and sign in user2
      logout user1
      login user2

      # User2 places a bid
      post :create_bid, params: { id: product.id, bid: { amount: 60 } }
      expect(response).to redirect_to(product)
      expect(flash[:notice]).to be_present

      # Additional assertions or expectations as needed
    end
  end
end
