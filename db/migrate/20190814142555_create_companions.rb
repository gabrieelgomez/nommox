class CreateCompanions < ActiveRecord::Migration[5.2]
  def change
    create_table :companions do |t|
      t.string :names
      t.string :surnames
      t.string :identification_document
      t.string :passport
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
