class CreateWeathericons < ActiveRecord::Migration[6.0]
  def change
    create_table :weathericons do |t|
      t.string :name

      t.timestamps
    end
  end
end
