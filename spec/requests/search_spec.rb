require 'rails_helper'

RSpec.describe "SearchProducts", type: :request do
  let!(:user) { create(:user) }
  let!(:product1) { create(:product, title: 'Unique Socks', user: user) }
  let!(:product2) { create(:product, title: 'Fast Bike', user: user) }
  let!(:product3) { create(:product, title: 'Socks with Polka Dots', user: user) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET /search" do
    context "with valid search term" do
      it "returns products that match the search term" do
        get search_products_path, params: { query: 'Socks' }
        expect(response.body).to include('Unique Socks')
        expect(response.body).to include('Socks with Polka Dots')
        expect(response.body).not_to include('Fast Bike')
      end
    end

    context "with empty search term" do
      it "returns all products" do
        get search_products_path, params: { query: '' }
        expect(response.body).to include('Unique Socks')
        expect(response.body).to include('Socks with Polka Dots')
        expect(response.body).to include('Fast Bike')
      end
    end

    context "with no matching search term" do
      it "returns no products" do
        get search_products_path, params: { query: 'Nonexistent' }
        expect(response.body).not_to include('Unique Socks')
        expect(response.body).not_to include('Socks with Polka Dots')
        expect(response.body).not_to include('Fast Bike')
      end
    end
  end
end

