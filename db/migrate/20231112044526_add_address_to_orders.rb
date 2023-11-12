class AddAddressToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :street, :string
    add_column :orders, :city, :string
    add_column :orders, :postal_code, :string
  end
end
