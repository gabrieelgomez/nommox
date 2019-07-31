class CreateAirlines < ActiveRecord::Migration[5.2]
  def change
    create_table :airlines do |t|
      t.string :name
      t.references :country, foreign_key: true
      t.string :phone

      t.timestamps
    end
  end
end
