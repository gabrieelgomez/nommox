class AddIncidentIdToCases < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :incident_id, :string
  end
end
