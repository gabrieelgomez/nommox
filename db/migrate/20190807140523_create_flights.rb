class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :departure_airport_code
      t.string :arrival_airport_code
      t.string :departure_airport_name
      t.string :arrival_airport_name
      t.datetime :date
      t.string :hour
      t.references :airline, foreign_key: true
      t.string :flight_number

      t.timestamps
    end
  end
end
