class AddContact < ActiveRecord::Migration
  def change
    add_column :contacts, :name, :string, null: false
    add_column :contacts, :email, :string, null: false
    add_column :contacts, :user_id, :integer, null: false

    add_index :contacts, :user_id, unique: true
  end
end
