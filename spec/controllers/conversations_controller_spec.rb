require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) { create(:user) }
  let(:product_params) do
    {
      product: {
        title: 'Sample Product',
        description: 'This is a sample description.',
        price: 50,
        condition: 'New',
        location: 'Sample City',
        category_id: 1
      }
    }
  end

  describe "POST /products" do
    context "as an authenticated user" do
      before do
        post login_path, params: { username: user.username, password: 'userpassword' }
      end

      it "creates a product" do
        expect {
          post products_path, params: product_params
        }.to change(Product, :count).by(1)
      end
    end
  end
end

