class AddProductIdToConversations < ActiveRecord::Migration[7.1]
  def change
    add_reference :conversations, :product, foreign_key: true
  end
end
