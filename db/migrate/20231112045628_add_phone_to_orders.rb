class AddPhoneToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :phone, :string
  end
end
