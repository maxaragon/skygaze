class AddWeathericonIdToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :weathericon_id, :integer
  end
end
