class AddBackToCompanions < ActiveRecord::Migration[5.2]
  def change
    add_column :companions, :back, :string
  end
end
