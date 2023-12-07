class AddEmailToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :email, :string
  end
end
