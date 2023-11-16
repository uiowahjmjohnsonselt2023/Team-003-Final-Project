Given('I am a logged-in user') do
  @user = User.create!(username: 'testuser', email: 'test@example.com', password: 'password')

  visit login_path

  fill_in 'Username', with: @user.username
  fill_in 'Password', with: 'password'
  click_button 'Login'
end

Given('I have a product in my cart') do
  @cart = @user.cart || @user.create_cart
  product = Product.create!(title: 'Example Product', price: 9.99, user: @user)

  CartItem.create!(product: product, cart: @cart, quantity: 1)
end

When('I proceed to checkout') do
  visit cart_path
  click_link 'Proceed to Checkout'
end

When('I provide my shipping and payment information') do
  fill_in 'Street', with: '123 Test St'
  fill_in 'City', with: 'Testville'
  fill_in 'Postal Code', with: '12345'
  fill_in 'Credit Card Number', with: '1234567890123456'
  fill_in 'Expiration Date', with: '12/34'
  fill_in 'CVV', with: '123'
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Phone Number', with: '123-456-7890'
end

When('I confirm the order') do
  click_button 'Place Order'
end

Then('I should see a confirmation that my order has been placed') do
  expect(page).to have_content('Thank you for your order!')
end
