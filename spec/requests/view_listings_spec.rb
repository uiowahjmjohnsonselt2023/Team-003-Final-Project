require 'rails_helper'

RSpec.describe 'User accessing listings', type: :feature do
  let(:user) { create(:user) }
  let!(:product) { create(:product, user: user) }
  let!(:listing) { create(:listing, user: user, product: product) }

  before do
    # Assuming you have a login method to handle user login
    login_path(user, scope: :user)
    visit profile_path
  end

  it 'allows user to view all active listings and navigate to a product detail page' do
    click_link 'Active Listings'

    expect(page).to have_current_path(listings_path)
    expect(page).to have_content(listing.title)

    # Click on a specific listing
    click_link listing.title

    # Verify redirection to the product's detail page
    expect(page).to have_current_path(product_path(listing.product))
    expect(page).to have_content(product.title)

    # Optionally, verify the ability to edit or delete the listing
    expect(page).to have_link('Edit')
    expect(page).to have_button('Delete')
  end
end
