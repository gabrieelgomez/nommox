class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.jsonb :videos, default: {}
      t.jsonb :images, default: {}
      t.jsonb :documents, default: {}
      t.jsonb :voices, default: {}
      t.references :case, foreign_key: true

      t.timestamps
    end
  end
end
