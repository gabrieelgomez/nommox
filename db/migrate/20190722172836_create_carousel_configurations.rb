class CreateCarouselConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :carousel_configurations do |t|
      t.string :text

      t.timestamps
    end
  end
end
