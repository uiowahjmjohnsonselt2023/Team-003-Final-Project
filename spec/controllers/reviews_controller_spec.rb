require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }

  before do
    post :create, params: { username: user.username, password: 'password' }
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a review" do
        review_params = {
          product_id: product.id,
          review: {
            title: "Great product",
            description: "I really enjoyed this product.",
            rating: 5
          }
        }

        expect {
          post :create, params: review_params
        }.to change(Review, :count).by(1)

        expect(response).to redirect_to(product_path(product))
      end
    end
  end
end



