class CreateLetters < ActiveRecord::Migration[5.2]
  def change
    create_table :letters do |t|
      t.references :country, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
