class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :street, :city, :postal_code, :credit_card_number, :expiration_date, :cvv, :email, :phone, presence: true

  order_params = {
    order: {
      street: "123 Test St",
      city: "Test City",
      postal_code: "12345",
      credit_card_number: "1234567890123456",
      expiration_date: "12/23",
      cvv: "123",
      email: "test@example.com",
      phone: "123-456-7890"
    }
  }

  def total_price
    order_items.sum { |item| item.quantity * item.product.price }
  end
end