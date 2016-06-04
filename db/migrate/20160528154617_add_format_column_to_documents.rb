class AddFormatColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :way, :integer
  end
end
