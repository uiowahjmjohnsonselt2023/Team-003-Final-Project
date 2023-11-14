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
    end

    it "creates an order and redirects to the order's page" do
      expect {
        post orders_path, params: { order: order_params }
      }.to change(Order, :count).by(1)

      order = Order.last
      expect(order).to be_present
      expect(response).to redirect_to(order_path(order))

      expect(order.errors.full_messages).to be_empty
    end

    it 'correctly processes order_params' do
      post orders_path, params: { order: order_params }

      expect(response).to redirect_to(order_path(Order.last))
      follow_redirect!

      expect(response.body).to include('Order was successfully placed.')
    end
  end
end



