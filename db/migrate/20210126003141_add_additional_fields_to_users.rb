class AddAdditionalFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :additional_information, :json, default: {}, null: false
  end
end
