class AddIdentificationDocumentBackAndFront < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :identification_document_back,  :string
    add_column :users, :identification_document_front, :string
  end
end
