class RemoveStatusToCases < ActiveRecord::Migration[5.2]
  def change
    remove_column :cases, :status, :string
  end
end
