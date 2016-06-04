class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :height
      t.integer :width

      t.timestamps null: false
    end
  end
end
