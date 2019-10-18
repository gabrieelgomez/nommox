class AddAsesorIdToCase < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :asesor_id, :string
  end
end
