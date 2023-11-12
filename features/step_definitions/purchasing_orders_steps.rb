Given('I am a registered user') do
  @user = FactoryBot.create(:user)
  login_as(@user)
end

Given('I have products in my cart') do
  product = FactoryBot.create(:product)
  @cart = FactoryBot.create(:cart, user: @user)
  FactoryBot.create(:cart_item, cart: @cart, product: product)
end

When('I proceed to checkout') do
  visit cart_path(@cart)
  click_on 'Checkout'
end

When('I provide shipping and payment information') do
  fill_in 'Street', with: '123 Fake Street'
  fill_in 'City', with: 'Faketown'
  fill_in 'Postal Code', with: '12345'
  fill_in 'Credit Card Number', with: '4111111111111111'
  fill_in 'Expiration Date', with: '12/24'
  fill_in 'CVV', with: '123'
end

When('I confirm the order') do
  click_on 'Place Order'
end

Then('I should see a confirmation message') do
  expect(page).to have_content('Order was successfully placed')
end

Then('the order should be recorded in the system') do
  expect(Order.exists?(user: @user)).to be true
end
