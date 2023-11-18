require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let!(:user) do
    User.create!(username: "MaryAnn", email: "maryann@example.com", password: "password")
  end

  let!(:category) do
    Category.create!(name: "Some Category")
  end

  let!(:product) do
    Product.create!(title: "Amazing Widget", price: 19.99, description: "An amazing widget", user: user, category: category)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'POST /products/:id/add_to_favorites' do
    it 'adds the product to favorites' do
      expect {
        post add_to_favorites_product_path(product)
      }.to change(Favorite, :count).by(1)

      expect(response).to redirect_to(product_path(product))
      follow_redirect!
      expect(response.body).to include('Product added to favorites.')
    end
  end

  describe 'DELETE /favorites/:id' do
    it 'removes the product from favorites' do
      favorite = user.favorites.create!(product: product)

      expect {
        delete favorite_path(product, favorite)
      }.to change(user.favorites, :count).by(-1)

      expect(response).to redirect_to(favorites_path)
      follow_redirect!
      expect(response.body).to include('Favorite was successfully removed.')
    end
  end
end



