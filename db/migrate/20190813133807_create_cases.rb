class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      t.integer :status
      t.string :video_self
      t.integer :hours_late, default: 0
      t.boolean :notifications_enabled, default: false
      t.string :case_cause_ids, default: [], array: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
