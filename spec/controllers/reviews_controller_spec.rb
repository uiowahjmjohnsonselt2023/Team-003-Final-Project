require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product, user: user) }
    let(:review_params) do
      {
        rating: 5,
        comment: 'I really enjoyed this product.',
        reviewer_id: user.id,
        reviewee_id: product.user.id,
        product_id: product.id
      }
    end

    before do
      # Stub current_user method to return the user
      allow(controller).to receive(:current_user).and_return(user)
      session[:user_id] = user.id
    end

    context 'with valid attributes' do
      it 'creates a review and redirects to the product page with a success message' do
        expect {
          post :create, params: { product_id: product.id, review: review_params }
        }.to change(Review, :count).by(1)

        expect(response).to redirect_to(product_path(product))
        expect(flash[:notice]).to eq('Review successfully submitted!')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a review and re-renders the product page with an alert' do
        invalid_review_params = { rating: 6, comment: 'This is way too long...' }

        expect {
          post :create, params: { product_id: product.id, review: invalid_review_params }
        }.not_to change(Review, :count)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('products/show')
      end
    end
  end
end






