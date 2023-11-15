require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }
  let!(:cart) do
    cart = Cart.create(user: user)
    cart.cart_items.create(product: product, quantity: 1)
    cart
  end

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:valid_attributes) do
        {
          street: '123 Main St',
          city: 'Example City',
          postal_code: '12345',
          credit_card_number: '1234-5678-9012-3456',
          expiration_date: '12/25',
          cvv: '123',
          email: user.email,
          phone: '123-456-7890',
          additional_instructions: 'Leave at the front door',
          product_id: product.id
        }
      end

      it "creates an order and redirects to the order's page" do
        expect {
          post :create, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)

        expect(response).to redirect_to(order_path(assigns(:order)))
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) do
        {
          street: '',
          city: '',
          postal_code: '',
          credit_card_number: '',
          expiration_date: '',
          cvv: '',
          email: '',
          phone: '',
          additional_instructions: '',
          product_id: product.id
        }
      end

      it 'does not create an order and renders the new template' do
        expect {
          post :create, params: { order: invalid_attributes }
        }.not_to change(Order, :count)
        expect(response).to render_template(:new)
      end
    end
  end
end

