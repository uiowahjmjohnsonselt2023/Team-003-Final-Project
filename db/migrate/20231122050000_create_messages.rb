class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.text :body
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.boolean :read, default: false
      t.bigint :conversation_id
      t.integer :receiver_id
      t.integer :user_id

      t.index :conversation_id
      t.index :receiver_id
    end
  end
end