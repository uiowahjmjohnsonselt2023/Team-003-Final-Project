class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :actor, null: false, foreign_key: { to_table: :users }
      t.string :action
      t.references :notifiable, polymorphic: true, null: false
      t.datetime :read_at

      t.timestamps
    end
  end
end

