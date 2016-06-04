class CreateAddons < ActiveRecord::Migration
  def change
    create_table :addons do |t|
      t.references :document, index: true, foreign_key: true
      t.string :source

      t.timestamps null: false
    end
  end
end
