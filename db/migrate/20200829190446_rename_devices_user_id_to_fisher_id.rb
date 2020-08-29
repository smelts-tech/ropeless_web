class RenameDevicesUserIdToFisherId < ActiveRecord::Migration[6.0]
  def change
    rename_column :devices, :user_id, :fisher_id
  end
end
