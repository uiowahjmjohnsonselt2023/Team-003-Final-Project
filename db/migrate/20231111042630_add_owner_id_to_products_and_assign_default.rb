class AddOwnerIdToProductsAndAssignDefault < ActiveRecord::Migration[7.1]
  def up
    default_owner = User.find_by(email: 'default_owner@example.com')
    unless default_owner
      default_owner = User.create!(
        username: 'default_owner',
        email: 'default_owner@example.com',
        password: 'valid_password'
        )
    end

    unless column_exists?(:products, :owner_id)
      add_reference :products, :owner, null: true, foreign_key: { to_table: :users }
    end

    Product.where(owner_id: nil).update_all(owner_id: default_owner.id)

    change_column_null :products, :owner_id, false
  end

  def down
    remove_reference :products, :owner, foreign_key: { to_table: :users }
  end
end

