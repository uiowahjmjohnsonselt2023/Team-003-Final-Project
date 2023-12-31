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

    context 'with no category selected' do
      it 'does not create a product and re-renders the new page with an alert' do
        invalid_product_params = { name: 'Product', description: 'This is a product.', category_id: nil }

        expect {
          post :create, params: { product: invalid_product_params }
        }.not_to change(Product, :count)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('products/new')
      end
    end
  end
end
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user, auction_enabled: true, auction_start_time: Time.now,auction_end_time: Time.now - 1.hour) }

  describe 'GET #end_auction' do
    context 'when the auction has ended' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        product.highest_bid = 50
        product.save
        get :end_auction, params: { id: product.id }
      end

      it 'awards the product to the highest bidder' do
        expect(product.reload.highest_bidder).to eq(user.id)
      end

      it 'sets auction_enabled to false' do
        expect(product.reload.auction_enabled).to eq(false)
      end

      it 'redirects to the product path' do
        expect(response).to redirect_to(product_path(product))
      end

      it 'sets a flash notice' do
        expect(flash[:notice]).to be_present
      end

      it 'puts the item into the user\'s cart' do
        user.create_cart unless user.cart
        # Reload the user to get the updated cart association
        user.reload

        # Debugging information
        puts "User's cart: #{user.cart.inspect}"
        puts "User's cart products: #{user.cart.products.inspect}"

        expect(user.cart.products).to include(product)
      end
    end

    context 'when the auction is not ended' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        get :end_auction, params: { id: product.id }
      end

      it 'does not award the product' do
        expect(product.reload.sold_to).to be_nil
      end

      it 'does not set auction_enabled to false' do
        expect(product.reload.auction_enabled).to be_truthy
      end

      it 'redirects to the product path' do
        expect(response).to redirect_to(product_path(product))
      end

      it 'sets a flash alert' do
        expect(flash[:alert]).to be_present
      end
    end
  end
end