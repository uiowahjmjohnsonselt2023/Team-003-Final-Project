require 'rails_helper'

RSpec.feature "Search Products with Filters", type: :feature do
  let(:user) { create(:user) }

  before do
    # create some products
    create(:product, title: "Amazing Widget", description: "An amazing widget", price: 50, condition: "New", user: user)
    create(:product, title: "Incredible Gadget", description: "A gadget like no other", price: 75, condition: "Used", user: user)
  end

  scenario "Searching for products with specific filters" do
    visit root_path
    fill_in 'query', with: "Widget"
    click_button 'Search'

    # apply filters
    select "New", from: "Condition"
    click_button 'Filter Results'

    expect(page).to have_content("Amazing Widget")
    expect(page).not_to have_content("Incredible Gadget")
  end
end
