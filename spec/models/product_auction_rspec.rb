require 'rails_helper'
require 'spec_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:auction_start_time) }
    it { should validate_presence_of(:auction_end_time) }
  end

  describe 'associations' do
    it { should have_many(:bids).dependent(:destroy) }
  end

  describe '#current_highest_bid' do
    it 'returns the highest bid amount' do
      product = create(:product)
      bid1 = create(:bid, product: product, amount: 50)
      bid2 = create(:bid, product: product, amount: 60)

      expect(product.current_highest_bid).to eq(60)
    end
  end
end
