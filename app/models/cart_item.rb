class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def decrease_quantity
    self.quantity -= 1 if quantity > 1
  end
end
