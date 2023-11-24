Given('I have an order with tracking information') do
  @order = FactoryBot.create(:order)
  @tracking = FactoryBot.create(:tracking, order: @order)
end

Given('I have an order without tracking information') do
  @order = FactoryBot.create(:order)
end

When('I visit the tracking page for the order') do
  visit trackings_show_path(order_id: @order.id)
end

Then('I should see the tracking information') do
  expect(page).to have_content(@tracking.tracking_number)
  expect(page).to have_content(@tracking.status.capitalize)
  expect(page).to have_content(@tracking.estimated_delivery_date)
  expect(page).to have_content(@tracking.shipping_carrier)
  expect(page).to have_content(number_to_currency(@order.total_price))
end

Then('I should see a message indicating tracking information is not available') do
  expect(page).to have_content("Tracking information not found.")
end