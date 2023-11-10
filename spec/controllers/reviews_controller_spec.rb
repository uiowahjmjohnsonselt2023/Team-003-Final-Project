require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:reviewer) { FactoryBot.create(:user) }
    let(:reviewee) { FactoryBot.create(:user) }
    
    it 'creates a review' do
      allow(controller).to receive(:current_user).and_return(reviewer)
      
      review_params = { rating: 4, comment: 'Great experience', reviewer_id: reviewer.id, reviewee_id: reviewee.id }

      post :create, params: { review: review_params }

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Review was successfully created.')
    end

    it 'does not create a review with invalid params' do
      allow(controller).to receive(:current_user).and_return(reviewer)

      invalid_review_params = { rating: 6, comment: 'This is way too long, way too long...', reviewer_id: reviewer.id, reviewee_id: reviewee.id }

      post :create, params: { review: invalid_review_params }

      expect(response).to render_template(:new)
    end
  end
end
