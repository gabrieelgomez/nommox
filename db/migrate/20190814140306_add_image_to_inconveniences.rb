class AddImageToInconveniences < ActiveRecord::Migration[5.2]
  def change
    add_column :inconveniences, :image, :string
  end
end
