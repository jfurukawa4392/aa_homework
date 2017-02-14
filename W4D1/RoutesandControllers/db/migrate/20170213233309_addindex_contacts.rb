class AddindexContacts < ActiveRecord::Migration
  def change
    remove_index(:contacts, name: "index_contacts_on_user_id")
    add_index(:contacts, [:user_id, :email], unique: true)
  end
end
