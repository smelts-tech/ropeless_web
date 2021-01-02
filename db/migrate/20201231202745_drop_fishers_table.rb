class DropFishersTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :fishers
  end

  def down
    create_table :fishers
  end
end
