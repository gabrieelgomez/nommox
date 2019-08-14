class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :code
      t.references :case, foreign_key: true

      t.timestamps
    end
  end
end
