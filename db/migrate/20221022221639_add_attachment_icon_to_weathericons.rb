class AddAttachmentIconToWeathericons < ActiveRecord::Migration[6.0]
  def self.up
    change_table :weathericons do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :weathericons, :icon
  end
end
