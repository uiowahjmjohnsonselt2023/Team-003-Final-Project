class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :street, :city, :postal_code, :credit_card_number, :expiration_date, :cvv, :email, :phone, presence: true

  def total_price
    order_items.sum { |item| item.quantity * item.product.price }
  end
end
