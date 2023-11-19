class ChangeStatusInTrackings < ActiveRecord::Migration[6.0]
  def up
    Tracking.where(status: nil).delete_all # Optional: clear out records with nil status if you have invalid data.
    change_column :trackings, :status, 'integer USING CAST(status AS integer)'
  end

  def down
    change_column :trackings, :status, :string
  end
end
