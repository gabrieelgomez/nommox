class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.jsonb :tickets, default: {}
      t.references :case, foreign_key: true

      t.timestamps
    end
  end
end
