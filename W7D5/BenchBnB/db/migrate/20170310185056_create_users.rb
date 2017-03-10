class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false

      t.timestamps
    end

    add_index :users, :user, unique: true
  end
end
