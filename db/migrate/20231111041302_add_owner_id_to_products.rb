class AddOwnerIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :owner, null: false, foreign_key: true
  end
end
