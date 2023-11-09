Given('I am on the login page') do
  visit '/login'
end

When('I log in with valid credentials') do
  fill_in 'Username', with: 'MaryAnn'
  fill_in 'Password', with: 'password'
  click_button 'Login'
end

Then('I should be logged in to the system') do
  puts page.body
  expect(page).to have_content('Logged in successfully.')
end


When('I log in with invalid credentials') do
  fill_in 'Username', with: 'wrong_username'
  fill_in 'Password', with: 'wrong_password'
  click_button 'Login'
end

Then('I should see a login error message') do
  expect(page).to have_content('Username or password is invalid')
end
