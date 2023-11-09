Given('I am on the login page') do
  visit '/login'
end

When('I fill in the login form correctly') do
  fill_in 'Username', with: 'MaryAnn'
  fill_in 'Password', with: 'password'
  click_button 'Login'
end

When('I click the login button') do
  click_button 'Login'
end

Then('I should be redirected to the home page') do
  expect(current_path).to eq(root_path)
  expect(page).to have_text("Welcome to the marketplace homepage!")
end

When('I fill in the login form with invalid credentials') do
  fill_in 'Username', with: 'invalid_username'
  fill_in 'Password', with: 'invalid_password'
end

Then('I should see a login error message') do
  expect(page).to have_content('Username or password is invalid')
end

Then(/^I should be on the login page$/) do
  expect(current_path).to eq('/login')
end

