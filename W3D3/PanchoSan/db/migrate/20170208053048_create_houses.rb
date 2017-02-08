class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :address, null: false
      t.timestamp
    end
  end
end
