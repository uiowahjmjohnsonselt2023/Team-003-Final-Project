class RemoveOwnerIdFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :owner_id, :integer
  end
end
