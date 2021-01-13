class FixUsersStatusType < ActiveRecord::Migration[6.0]
  def change
    # postgres complained about casting the default value of `status` so first set it to `nil`
    change_column :users, :status, :string, default: nil
    # change the column type to the proper `integer` type and cast existing values
    change_column :users, :status, 'integer USING CAST(status AS integer)'
    # now reset the default to `0`
    change_column :users, :status, :integer, default: 0
  end
end
