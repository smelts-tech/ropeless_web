class AddAddressFieldToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :city, :string, limit: 128
    add_column :users, :state, :string, limit: 128
    add_column :users, :zip_code, :string, limit: 5
  end
end
