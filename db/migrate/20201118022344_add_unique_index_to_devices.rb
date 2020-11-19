class AddUniqueIndexToDevices < ActiveRecord::Migration[6.0]
  def change
    add_index :devices, :md5_hash, unique: true
  end
end
