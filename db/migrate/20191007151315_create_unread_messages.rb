class CreateUnreadMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :unread_messages do |t|
      t.string :channel
      t.integer :messages_count

      t.timestamps
    end
  end
end
