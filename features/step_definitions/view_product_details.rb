Given(/^a product is listed in the marketplace with a review$/) do
  @category = Category.find_or_create_by!(name: "Electronics")
  @user = User.create!(username: 'TestUser', email: 'test@example.com', password: 'password')
  @product = Product.create!(
    title: 'Test Product',
    description: 'Test Description',
    user: @user,
    category: @category
  )
  @review = Review.create!(
    comment: 'Great product',
    rating: 5,
    reviewer: @user,
    reviewee: @product.user,
    product: @product
  )
end

Given('I am logged in as the reviewing user') do
  page.set_rack_session(user_id: @user.id)
end

When("I visit the product details page") do
  @category = Category.create!(name: "Example Category")
  @product = create(:product, category: @category)
  @product_id = @product.id
  visit product_path(@product_id)
end

Then('I should see the product details') do
  expect(page).to have_content(@product.title)
  expect(page).to have_content(@product.description)
  expect(page).to have_content(sprintf('%.2f', @product.price))
end

Then('I should see an {string} button') do |button_text|
  expect(page).to have_button(button_text)
end

When('I click on the "Delete Review" button for the review') do
  review_elements = all('div', text: @review.comment, wait: 10)

  review_elements.each do |review_element|
    if review_element.has_button?('Delete Review')
      review_element.click_button('Delete Review')
      break
    end
  end
end

Then('I should see a {string} section') do |section|
  expect(page).to have_css('h3', text: section)
end

Then('I should not see the review content') do
  expect(page).to_not have_content(@review.comment)
end

Then('I should be on the product details page') do
  expect(current_path).to eq product_path(@product)
end
