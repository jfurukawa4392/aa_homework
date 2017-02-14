class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commenter_id, null: false
      t.integer :comentee_id, null: false
      t.timestamps
    end
  end
end
