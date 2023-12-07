class AddSavePaymentInfoToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :save_payment_info, :boolean
  end
end
