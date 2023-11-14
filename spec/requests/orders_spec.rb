require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }

  before do
    post login_path, params: { username: user.username, password: 'password' }
  end

  describe "POST /create" do
    let(:order_params) do
      {
        order: {
          street: '123 Main St',
          city: 'Example City',
          postal_code: '12345',
          credit_card_number: '1234-5678-9012-3456',
          expiration_date: '12/25',
          cvv: '123',
          email: 'user@example.com',
          phone: '123-456-7890',
          additional_instructions: 'Example instructions',
          save_payment_info: true,
          product_id: product.id,
        }
      }
    end

    it "creates an order and redirects to the order's page" do
      expect {
        post orders_path, params: order_params
      }.to change(Order, :count).by(1)

      expect(response).to redirect_to(Order.last)
    end

    it "correctly processes order_params" do
      post orders_path, params: order_params
      expect(assigns(:order).attributes.symbolize_keys).to include(order_params[:order])
    end
  end
end


