class AddAdditionalInstructionsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :additional_instructions, :text
  end
end
