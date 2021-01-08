class UsersStiFields < ActiveRecord::Migration[6.0]
  def change
    add_column :users,  :type, :string, null: false, default: "User"
    add_column :users, :status, :string, default: 0, null: false

    add_column :users, :permit_number, :string
    add_column :users, :address, :string, limit: 1024
    add_column :users, :phone_number, :string, limit: 128

    remove_column :users, :role, :string
    remove_column :users, :permit, :string
  end
end
