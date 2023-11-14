class CreateTrackings < ActiveRecord::Migration[7.1]
  def change
    create_table :trackings do |t|

      t.timestamps
    end
  end
end
