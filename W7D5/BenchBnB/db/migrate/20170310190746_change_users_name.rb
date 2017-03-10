class ChangeUsersName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :user, :username
  end
end
