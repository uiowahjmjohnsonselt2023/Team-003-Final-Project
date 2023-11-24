require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:category) { FactoryBot.create(:category) }
    let(:product_params) do
      {
        name: 'Product',
        description: 'This is a product.',
        price: 10.00,
        user_id: user.id,
        category_id: category.id,
        condition: 'new',
        location: 'New York'
      }
    end

    before do
      # Stub current_user method to return the user
      allow(controller).to receive(:current_user).and_return(user)
      session[:user_id] = user.id
    end

    context 'with valid attributes' do
      it 'creates a product and redirects to the product page with a success message' do
        expect {
          post :create, params: { product: product_params }
        }.to change(Product, :count).by(1)

        expect(response).to redirect_to(product_path(Product.last))
        expect(flash[:notice]).to eq('Product added!')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a product and re-renders the new page with an alert' do
        invalid_product_params = { name: 'Product', description: 'This is a product.' }

        expect {
          post :create, params: { product: invalid_product_params }
        }.not_to change(Product, :count)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('products/new')
      end
    end
  end
end