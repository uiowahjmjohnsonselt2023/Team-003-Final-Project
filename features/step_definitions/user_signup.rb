Given("the signup page is available") do
  visit '/signup'
end

When("I fill in the following:") do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

When(/^I fill in the signup "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When("I fill in the {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I choose a file {string} to upload as my profile picture") do |file_name|
  attach_file('Profile picture', File.absolute_path(file_name))
end

When("I click the {string} button") do |button_name|
  click_button button_name
end

Then("I should be redirected to the marketplace home page") do
  expect(current_path).to eq('/')
end

Then("the new user should be stored in the database") do
  expect(User.count).to eq(1)
end

Then("I should not be redirected to the marketplace home page") do
  expect(current_path).not_to eq('/')
end

Then("I should see an error message {string}") do |message|
  expect(page).to have_content(message)
end

Then("the new user should not be stored in the database") do
  expect(User.count).to eq(0)
end