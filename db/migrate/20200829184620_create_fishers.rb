class CreateFishers < ActiveRecord::Migration[6.0]
  def change
    create_table :fishers do |t|
      t.string        :name
      t.string        :email
      t.string        :license_number
      t.timestamps
    end
  end
end
