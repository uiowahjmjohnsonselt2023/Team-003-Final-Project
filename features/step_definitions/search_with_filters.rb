Given('I am on the homepage ready to search') do
  visit root_path
end

Given('a user exists') do
  @user = User.create!(username: 'TestUser', email: 'test@example.com', password: 'password')
end

Given(/^the following searchable products exist:$/) do |table|
  user = User.find_by(username: 'maryAnn') || User.create!(
    name: 'mary',
    username: 'maryAnn',
    email: 'maryann@example.com',
    password: 'password'
  )

  table.hashes.each do |product_attributes|
    title = product_attributes['title']
    description = product_attributes['description']
    price = product_attributes['price']
    condition = product_attributes['condition']
    category_name = product_attributes['category'] || "Default Category"

    category = Category.find_or_create_by!(name: category_name)

    user.products.create!(
      title: title,
      description: description,
      price: price,
      condition: condition,
      category: category,
      auction_enabled: false,
      starting_bid: 10,
      highest_bid: 10
    )
  end
end

When('I fill in the search field with {string}') do |search_term|
  fill_in 'query', with: search_term
end

When('I click the "Search" button on the homepage') do |button_text|
  click_button button_text
end

When("I select {string} from the {string} dropdown") do |option, dropdown_label|
  find("label", text: dropdown_label).find(:xpath, '..').select(option)
end

When('I click the "Filter Results" button on the search page') do
  click_button 'Filter Results'
end

Then('I should see "Amazing Widget" on the search page') do
  expect(page).to have_content("Amazing Widget")
end

Then('I should not see "Incredible Gadget"') do
  expect(page).not_to have_content("Incredible Gadget")
end
