require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }
  let(:order_params) do
    {
      order: {
        product_id: product.id,
      }
    }
  end

  before do
    post login_path, params: { username: user.username, password: 'password' }
  end

  describe "POST /create" do
    it "creates an order and redirects to the order's page" do
      expect {
        post orders_path, params: order_params
      }.to change(Order, :count).by(1)

      expect(response).to redirect_to(Order.last)
    end
  end
end

