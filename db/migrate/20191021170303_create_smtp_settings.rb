class CreateSmtpSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :smtp_settings do |t|
      t.string :password

      t.timestamps
    end
  end
end
