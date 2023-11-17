# create a test user with the provided user_data taken from User model
def create_test_user(user_data)
  user = User.new(user_data)

  # validate and save the user
  if user.valid?
    user.save
  else
    raise "User validation failed: #{user.errors.full_messages.join(', ')}"
  end
end

# create a registered user
Given /^I am a registered user for login$/ do
  @user = User.create!(
    email: 'john@example.com',
    username: 'john_doe',
    password: 'password123'
  )
end

# visit the login page
Given(/^I am on the login page$/) do
  visit('/login')
end

# visit the login page with the provided credentials (username and password fields)
Given(/^I am on the login page with the following credentials:$/) do |table|
  user_data = table.hashes.first
  visit('/login')
  fill_in 'Username', with: @user.username
  fill_in 'Password', with: @user.password
end

# fill in login form fields
When(/^I fill in the login "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

# click a button (the login button)
When(/^I press "([^"]*)"$/) do |button_name|
  click_button button_name
end

# check that the user is on the home page (the root route)
Then(/^I should be on the home page of the marketplace$/) do
  expect(current_path).to eq('/')
end

# check that the user is on the login page (this is for if the user has an invalid login)
Then(/^I should be on the login page$/) do
  expect(current_path).to eq('/login')
end

# check for text on the page (to see if an error message displays)
Then(/^I should see "([^"]*)"$/) do |expected_text|
  expect(page).to have_text(expected_text)
end

