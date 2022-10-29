class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :macaddress
      t.string :unique_va
      t.string :device_token
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
