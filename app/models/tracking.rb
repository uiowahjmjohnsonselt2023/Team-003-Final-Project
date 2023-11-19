class Tracking < ApplicationRecord
  belongs_to :order
  enum status: { processing: 0, shipped: 1, in_transit: 2, delivered: 3, cancelled: 4 }
end
