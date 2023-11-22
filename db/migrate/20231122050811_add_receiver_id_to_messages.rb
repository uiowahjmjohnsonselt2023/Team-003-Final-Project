class AddReceiverIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :receiver_id, :integer
    add_index :messages, :receiver_id
    add_foreign_key :messages, :users, column: :receiver_id
  end
end
