class AddRecipientIdToConversations < ActiveRecord::Migration[7.1]
  def change
    add_column :conversations, :recipient_id, :integer
  end
end