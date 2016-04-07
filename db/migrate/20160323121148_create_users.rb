class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :full_name
      t.string :password_digest
      t.integer :role
      t.string :groups

      t.timestamps null: false
    end
  end
end
