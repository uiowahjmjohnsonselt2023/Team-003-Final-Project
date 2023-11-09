def create_test_user(user_data)
  user = User.new(user_data)

  # Validate and save the user
  if user.valid?
    user.save
  else
    raise "User validation failed: #{user.errors.full_messages.join(', ')}"
  end
end

Given /^I am a registered user$/ do
  @user = User.create!(
    email: 'john@example.com',
    username: 'john_doe',
    password: 'password123'
  )
end

Given(/^I am on the login page$/) do
  visit('/login')
end

Given(/^I am on the login page with the following credentials:$/) do |table|
  user_data = table.hashes.first
  visit('/login')
  fill_in 'Username', with: @user.username
  fill_in 'Password', with: @user.password
end

# Fill in login form fields
When(/^I fill in the login "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

# Click a button
When(/^I press "([^"]*)"$/) do |button_name|
  click_button button_name
end

# Check that the user is on the home page
Then(/^I should be on the home page of the marketplace$/) do
  expect(current_path).to eq('/')
  expect(page).to have_text("Welcome to the marketplace homepage!")
end

# Check that the user is on the login page
Then(/^I should be on the login page$/) do
  expect(current_path).to eq('/login')
end

# Check for text on the page
Then(/^I should see "([^"]*)"$/) do |expected_text|
  expect(page).to have_text(expected_text)
end

