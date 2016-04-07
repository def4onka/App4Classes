class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :document, index: true, foreign_key: true
      t.text :source
      t.integer :position

      t.timestamps null: false
    end
  end
end
