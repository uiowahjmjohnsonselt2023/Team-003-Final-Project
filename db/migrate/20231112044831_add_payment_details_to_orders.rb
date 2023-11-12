class AddPaymentDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :credit_card_number, :string
    add_column :orders, :expiration_date, :string
    add_column :orders, :cvv, :string
  end
end
