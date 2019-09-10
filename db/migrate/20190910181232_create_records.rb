class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :call_sid
      t.string :record_url

      t.timestamps
    end
  end
end
