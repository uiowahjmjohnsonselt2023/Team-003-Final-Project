class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :street, :city, :postal_code, :credit_card_number, :expiration_date, :cvv, :email, :phone, presence: true

  def total_price
    order_items.sum { |item| item.quantity * item.product.price }
  end
end
