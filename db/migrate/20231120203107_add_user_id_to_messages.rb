class AddUserIdToMessages < ActiveRecord::Migration[6.0]
  def up
    add_reference :messages, :user, null: true, foreign_key: true
    default_user_id = 1
    Message.update_all(user_id: default_user_id)
    change_column_null :messages, :user_id, false
  end

  def down
    remove_reference :messages, :user
  end
end