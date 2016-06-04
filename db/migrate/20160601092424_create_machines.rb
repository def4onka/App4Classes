class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.references :room, index: true, foreign_key: true
      t.string :left
      t.string :top

      t.timestamps null: false
    end
  end
end
