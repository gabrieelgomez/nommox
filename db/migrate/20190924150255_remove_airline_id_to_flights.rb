class RemoveAirlineIdToFlights < ActiveRecord::Migration[5.2]
  def change
    remove_column :flights, :airline_id, :string
  end
end
