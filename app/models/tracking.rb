class Tracking < ApplicationRecord
  belongs_to :order

  enum status: { processing: 0, shipped: 1, in_transit: 2, delivered: 3, cancelled: 4 }

  def estimated_delivery_date
    # assume delivery within 3-5 days from the created_at date
    (created_at + 3.days).strftime('%B %d, %Y') + ' - ' + (created_at + 5.days).strftime('%B %d, %Y')
  end
end
