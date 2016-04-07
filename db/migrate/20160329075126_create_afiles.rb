class CreateAfiles < ActiveRecord::Migration
  def change
    create_table :afiles do |t|
      t.references :document, index: true, foreign_key: true
      t.binary :source
      t.string :path

      t.timestamps null: false
    end
  end
end
