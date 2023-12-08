class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :amount, presence: true, numericality: {greater_than: 0}
end