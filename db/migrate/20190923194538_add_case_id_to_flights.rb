class AddCaseIdToFlights < ActiveRecord::Migration[5.2]
  def change
    add_reference :flights, :case, foreign_key: true
  end
end
