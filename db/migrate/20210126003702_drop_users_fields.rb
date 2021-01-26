class DropUsersFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :permit_number, :string
    remove_column :users, :address, :string
    remove_column :users, :phone_number, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :zip_code, :string
  end
end
