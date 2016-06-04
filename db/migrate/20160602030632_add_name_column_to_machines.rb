class AddNameColumnToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :name, :string
  end
end
