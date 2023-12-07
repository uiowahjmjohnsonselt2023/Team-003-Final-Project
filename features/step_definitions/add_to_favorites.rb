Given("the following users exist:") do |table|
  table.hashes.each do |user_attributes|
    User.create!(user_attributes)
  end
end

Given("the following products exist:") do |table|
  user = User.first || User.create!(username: "MaryAnn", email: "mary@example.com", password: "password", password_confirmation: "password")

  category = Category.first || Category.create!(name: "Default Category")

  table.hashes.each do |product_attributes|
    Product.create!(product_attributes.merge(user: user, category: category))
  end
end

Given("I am logged in as a buyer") do
  username = "MaryAnn"
  email = "#{username}_#{Time.now.to_i}@example.com"
  password = "password"

  @buyer = User.find_by(username: username)

  unless @buyer
    @buyer = User.create!(username: username, email: email, password: password, password_confirmation: password)
  end

  visit login_path
  fill_in "Username", with: username
  fill_in "Password", with: password
  click_button "Login"
end

Given("I view the details for {string}") do |product_title|
  product = Product.find_by_title(product_title)
  visit product_path(product)
end

Given("I have favorited {string}") do |product_title|
  product = Product.find_by_title(product_title)
  Favorite.create!(product: product, user: @buyer)
end

When("I click on {string}") do |button_text|
  click_button button_text
end

When("I visit the {string} page") do |page_name|
  visit path_to(page_name)
end

When("I click on {string} for {string}") do |button_text, product_title|
  product = Product.find_by(title: product_title)
  within(".favorite-item", text: product_title) do
    click_button button_text
  end
end

Then("I should be on the product details page for {string}") do |product_title|
  product = Product.find_by_title(product_title)
  expect(page.current_path).to eq product_path(product)
end

Then("I should see {string} message") do |expected_message|
  expect(page).to have_text(expected_message)
end

Then("I should see {string} in my favorites") do |product_title|
  expect(page).to have_css('.favorites-container')
  within('.favorites-container') do
    expect(page).to have_content(product_title)
  end
end

Then("I should not see {string} in my favorites") do |product_title|
  expect(page).not_to have_content(product_title)
end
def path_to(page_name)
  case page_name.downcase
  when "favorites"
    favorites_path
  else
    raise "Path to specified page is not defined"
  end
end
