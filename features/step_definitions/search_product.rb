Given('the following users exist for search:') do |table|
  table.hashes.each do |user_attributes|
    User.create!(user_attributes)
  end
end

Given('the following products exist for search:') do |table|
  user = User.find_by(username: 'MaryAnn') || User.create!(
    username: 'MaryAnn',
    email: 'mary@example.com',
    password: 'password'
  )

  table.hashes.each do |product_attributes|
    category_name = product_attributes.delete('category')
    category = Category.find_or_create_by!(name: category_name)

    Product.create!(product_attributes.merge({
                                               user: user,
                                               category: category,
                                               auction_enabled: false,
                                               starting_bid: 10,
                                               highest_bid: 10
                                             }))
  end
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



