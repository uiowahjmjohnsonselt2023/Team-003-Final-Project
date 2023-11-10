Given('a product is listed in the marketplace with a review') do
  user = FactoryBot.create(:user)
  @product = FactoryBot.create(:product, user: user)
  @review = FactoryBot.create(:review, product: @product, user: user)
end

Given('I am logged in as the reviewing user') do
  page.set_rack_session(user_id: @review.user.id)
end

When('I visit the product details page') do
  visit product_path(@product)
end

Then('I should see the product details') do
  expect(page).to have_content(@product.title)
  expect(page).to have_content(@product.description)
  expect(page).to have_content(sprintf('%.2f', @product.price))
end

Then('I should see an {string} button') do |button_text|
  expect(page).to have_button(button_text)
end

When('I click on the {string} button for the review') do |button_text|
  within('.review', text: @review.content) do
    click_button(button_text)
  end
end

Then('I should see a {string} section') do |section|
  expect(page).to have_css('h3', text: section)
end

Then('I should not see the review content') do
  expect(page).to_not have_content(@review.content)
end

Then('I should be on the product details page') do
  expect(current_path).to eq product_path(@product)
end

Then('I should see a {string} message') do |message|
  expect(page).to have_content(message)
end
