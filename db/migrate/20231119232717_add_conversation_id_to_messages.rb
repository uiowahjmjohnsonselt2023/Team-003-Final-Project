class AddConversationIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :conversation, foreign_key: true
  end
end