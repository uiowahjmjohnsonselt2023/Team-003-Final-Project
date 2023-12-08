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
          auction_enabled: true,
          auction_start_time: 1.hour.ago,
          auction_end_time: 1.hour.from_now
        )

        post :create_bid, params: { id: product.id, bid: { amount: 50 } }
        expect(response).to redirect_to(product)
        expect(flash[:notice]).to be_present
      end
    end
  end

end
