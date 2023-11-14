require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, user: user) }

  before do
    session[:user_id] = user.id
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a review" do
        review_params = {
          rating: 5,
          comment: "I really enjoyed this product."
        }

        expect {
          post :create, params: { product_id: product.id, review: review_params }
        }.to change(Review, :count).by(1)

        expect(response).to redirect_to(product_path(product))
        expect(flash[:notice]).to eq('Review successfully submitted!')
      end
    end
  end
end




