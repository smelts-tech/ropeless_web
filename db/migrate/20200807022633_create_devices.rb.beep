class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.belongs_to :user
      t.timestamp :dt
      t.string :mac_address, limit: 40
      t.string :vessel_id
      t.st_point :geom, geographic: true
      t.timestamps
    end

    add_index :devices, :dt
    add_index :devices, :geom, using: :gist
  end
end
