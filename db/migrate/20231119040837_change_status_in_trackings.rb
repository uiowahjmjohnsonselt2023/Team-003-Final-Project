class ChangeStatusInTrackings < ActiveRecord::Migration[7.1]
  def up
    change_column :trackings, :status, 'integer USING CAST(status AS integer)'
  end

  def down
    change_column :trackings, :status, :string
  end
end
