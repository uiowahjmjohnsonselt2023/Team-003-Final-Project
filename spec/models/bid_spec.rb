# spec/models/bid_spec.rb
require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe 'multiple users bidding on a product' do
    let(:user1) { User.create(name: 'User 1', email: 'user1@example.com', password: 'password') }
    let(:user2) { User.create(name: 'User 2', email: 'user2@example.com', password: 'password') }
    let(:product) { Product.create(title: 'Test Product', user: user1, condition: 'New', location: 'Test Location', price: 100) }

    it 'allows multiple users to bid on a product' do
      bid1 = Bid.create(product: product, user: user1, amount: 50)
      bid2 = Bid.create(product: product, user: user2, amount: 60)

      expect(bid1).to be_valid
      expect(bid2).to be_valid
      expect(product.bids.count).to eq(2)
    end

    it 'requires a valid bid amount' do
      invalid_bid = Bid.new(product: product, user: user1, amount: 0)

      expect(invalid_bid).not_to be_valid
      expect(invalid_bid.errors[:amount]).to include('must be greater than 0')
    end
  end
end
