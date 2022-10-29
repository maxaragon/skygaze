class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.string :addres
      t.string :altitude
      t.string :compass_value
      t.string :comment
      t.string :icon

      t.timestamps
    end
  end
end
