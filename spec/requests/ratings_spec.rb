RSpec.describe "Products", type: :request do
  describe "GET /products/:id" do
    let(:seller) { create(:user) }
    let(:reviewer) { create(:user) }
    let(:product) { create(:product, user: seller) }

    before do
      create_list(:review, 3, reviewee: seller, reviewer: reviewer, product: product, comment: "Excellent!", rating: 5)
      get product_path(product)
    end

    it "displays the seller's average rating" do
      expect(response.body).to include('Average Rating: 5.0 / 5')
    end
  end
end
