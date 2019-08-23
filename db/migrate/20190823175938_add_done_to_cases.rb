class AddDoneToCases < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :done, :boolean, default: false
  end
end
