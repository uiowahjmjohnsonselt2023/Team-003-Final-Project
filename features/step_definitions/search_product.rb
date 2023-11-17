Given("the following users exist for search:") do |table|
  table.hashes.each do |user|
    User.create!(user)
  end
end

Given('a product is listed in the marketplace with a review') do
  # ensure a category exists
  category = Category.find_or_create_by(name: 'Electronics')

  # create a user if not already present
  user = User.find_or_create_by(username: 'ExampleUser', email: 'user@example.com', password: 'password')

  # create a product with the given details and the existing category
  product = Product.create!(
    title: 'Amazing Widget',
    description: 'An amazing widget description',
    user: user,
    category: category,
    price: 50.00
  )

  # create a review for the product
  Review.create!(
    rating: 5,
    comment: 'Great product!',
    product: product,
    reviewer: user
  )
end

Given("I am on the homepage") do
  visit root_path
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When('I click the "Search" button on the home page') do
  click_button
end

Then("I should see {string} as clickable") do |link|
  expect(page).to have_link(link)
end

When('I click on the product titled {string}') do |product_title|
  click_link product_title
end

Then("I should be on the details page for {string}") do |product_title|
  product = Product.find_by(title: product_title)
  expect(page.current_path).to eq product_path(product)
end

