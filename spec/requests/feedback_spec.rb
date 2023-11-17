require 'rails_helper'

RSpec.describe FeedbackController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product) }
  let(:order) { FactoryBot.create(:order, user: user, product_id: product.id) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "GET /new" do
    it "returns http success" do
      get new_order_feedback_path(order_id: order.id)
      expect(response).to have_http_status(:success)
    end
  end
end
