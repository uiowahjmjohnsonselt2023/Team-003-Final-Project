class Tracking < ApplicationRecord
  attr_accessor :tracking_number
  belongs_to :order

end
