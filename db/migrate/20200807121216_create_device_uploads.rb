class CreateDeviceUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :device_uploads do |t|
      t.belongs_to    :fisher
      t.timestamps
    end
  end
end
