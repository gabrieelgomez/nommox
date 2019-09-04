class AddCodeToAirlines < ActiveRecord::Migration[5.2]
  def change
    add_column :airlines, :code, :string
  end
end
