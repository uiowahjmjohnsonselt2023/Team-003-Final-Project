require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:reviewer) { FactoryBot.create(:user) }
    let(:reviewee) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product)}
 
    it 'creates a review and redirects to home page' do
      allow(controller).to receive(:current_user).and_return(reviewer)
  
      review_params = { rating: 4, comment: 'Great experience', reviewer_id: reviewer.id, reviewee_id: reviewee.id, product_id: product.id }
  
      post :create, params: { review: review_params, product_id: product.id } # Ensure product_id is passed
  
      expect(response).to redirect_to(products_path + "/#{product.id}")
      expect(flash[:notice]).to eq('Review successfully submitted!')
      end

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

      invalid_review_params = { rating: 6, comment: 'This is way too long, way too long...', reviewer_id: reviewer.id, reviewee_id: reviewee.id, product_id: product.id }

      post :create, params: { review: invalid_review_params, product_id: product.id }

      expect(response).to redirect_to(products_path + "/#{product.id}")
      expect(flash[:alert]).to eq('There was a problem submitting your review.')
        expect(response).to redirect_to(product_path(product))
        expect(flash[:notice]).to eq('Review successfully submitted!')
      end
    end
  end
  end
end





