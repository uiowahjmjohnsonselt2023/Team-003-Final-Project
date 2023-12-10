class AddProductIdToConversations < ActiveRecord::Migration[6.0]
  def change
    # add_reference :conversations, :product, foreign_key: true, index: true, null: true
  end
end