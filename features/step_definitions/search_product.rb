Given("the following products exist:") do |table|
  table.hashes.each do |hash|
    Product.create!(title: hash['title'], description: hash['description'])
  end
end

When("I search for {string}") do |search_term|
  visit root_path
  fill_in 'search_query', with: search_term
  click_button 'Search'
end


When("I search with an empty keyword") do
  visit root_path
  fill_in 'search_query', with: ''
  click_button 'Search'
end

Then("I should see products including:") do |table|
  table.raw.flatten.each do |title|
    expect(page).to have_content(title)
  end
end

Then("I should not see any products") do
  expect(page).not_to have_css('.product')
end
Then("I should see all products") do
  Product.all.each do |product|
    expect(page).to have_content(product.title)
  end
end
