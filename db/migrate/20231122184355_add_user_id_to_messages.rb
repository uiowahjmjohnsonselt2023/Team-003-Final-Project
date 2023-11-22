class AddUserIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :user, null: true, foreign_key: true
  end
end
