# visit the signup page
Given("the signup page is available") do
  visit '/signup'
end

# fill in the form fields using a table (check user_signup.feature)
When("I fill in the following:") do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

# fill in a specific signup field with a value
When("I fill in the following signup information:") do |table|
  table.rows_hash.each do |field, value|
    fill_in field.to_sym, with: value
  end
end

# fill in a field with a given value
When("I fill in the {string} with {string}") do |field, value|
  fill_in field, with: value
end

# upload profile picture
When("I choose a file {string} to upload as my profile picture") do |file_name|
  attach_file('Profile picture', File.absolute_path(file_name))
end

# click a button (the signup button)
When("I click the {string} button") do |button_name|
  click_button button_name
end

# check if redirected to the marketplace home page
Then("I should be redirected to the marketplace home page") do
  expect(current_path).to eq('/')
end

# check if the new user is stored in the database
Then("the new user should be stored in the database") do
  expect(User.count).to eq(1)
end

# check if not redirected to the marketplace home page
Then("I should not be redirected to the marketplace home page") do
  expect(current_path).not_to eq('/')
end

# check if error message is displayed
Then("I should see an error message {string}") do |message|
  expect(page).to have_content(message)
end

# check if the new user is not stored in the database (if user fails signup form)
Then("the new user should not be stored in the database") do
  expect(User.count).to eq(0)
end