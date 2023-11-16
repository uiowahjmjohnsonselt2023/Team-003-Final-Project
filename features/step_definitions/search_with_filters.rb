Given('I am on the homepage ready to search') do
  visit root_path
end

Given('a user exists') do
  @user = User.create!(username: 'TestUser', email: 'test@example.com', password: 'password')
end

Given('the following searchable products exist:') do |table|
  table.hashes.each do |product_attrs|
    Product.create!(product_attrs.merge(user: @user))
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
