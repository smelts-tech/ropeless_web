class AddRoleAndPermitToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string, default: "fisher"
    add_column :users, :permit, :string
    add_index :users, :role
    add_index :users, :permit, unique: true
  end
end
