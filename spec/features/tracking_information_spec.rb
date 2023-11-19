require 'rails_helper'

RSpec.feature "TrackingInformation", type: :feature do
  context 'when order has tracking information' do
    let(:order) { create(:order) }
    let!(:tracking) { create(:tracking, order: order) }

    it 'displays the tracking information' do
      visit trackings_show_path(order_id: order.id)

      expect(page).to have_content("Tracking Information")
      expect(page).to have_content(tracking.tracking_number)
      expect(page).to have_content(tracking.status.capitalize)
      expect(page).to have_content(tracking.estimated_delivery_date)
      expect(page).to have_content(tracking.shipping_carrier)
      expect(page).to have_content(number_to_currency(order.total_price))
      order.order_items.each do |item|
        expect(page).to have_content(item.quantity)
        expect(page).to have_content(item.product.title)
        expect(page).to have_content(number_to_currency(item.product.price))
      end
    end
  end

  context 'when order does not have tracking information' do
    let(:order) { create(:order) }

    it 'displays a message that tracking information is not available' do
      visit trackings_show_path(order_id: order.id)

      expect(page).to have_content("Tracking information not found.")
    end
  end
end