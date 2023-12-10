Given('I am a registered user for user profile') do
  @user = User.create!(
    name: 'John Doe',
    username: 'john_doe',
    email: 'john@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    bio: 'Just a regular John Doe.'
  )
end

Given('I am on the login page with the following credentials for user profile:') do |table|
  credentials = table.rows_hash
  visit('/login')
  fill_in 'Username', with: credentials['Username']
  fill_in 'Password', with: credentials['Password']
end

Given('I fill in the following for user profile:') do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

When('I press {string} for user profile') do |button_name|
  click_button button_name
end

When('I click the {string} button for user profile') do |button_name|
  click_button button_name
end

Then('I should see {string} for user profile') do |expected_text|
  expect(page).to have_text(expected_text)
end
