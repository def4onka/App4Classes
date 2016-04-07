class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.references :document, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :comment
      t.string :groups, array: true
      t.integer :last_open_slide
      t.boolean :auto_open

      t.timestamps null: false
    end
  end
end
