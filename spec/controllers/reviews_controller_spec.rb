require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }

  before do
    login_path user
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a review" do
        review_params = { }
        expect {
          post :create, params: review_params
        }.to change(Review, :count).by(1)
      end
    end
  end
end



