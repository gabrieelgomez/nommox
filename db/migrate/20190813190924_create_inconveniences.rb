class CreateInconveniences < ActiveRecord::Migration[5.2]
  def change
    create_table :inconveniences do |t|
      t.boolean :lost_connection, default: false
      t.boolean :lost_event, default: false
      t.text :description
      t.references :case, foreign_key: true

      t.timestamps
    end
  end
end
