class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.belongs_to :fisher
      t.timestamp :dt
      t.string :modem_id
      t.st_point :geom, geographic: true
      t.string :md5_hash, limit: 32, null: false
      t.string :event_type, limit: 30
      t.string :altitude, limit: 10
      t.string :depth, limit: 10
      t.timestamps
    end

    add_index :devices, :dt
    add_index :devices, :geom, using: :gist
  end
end
