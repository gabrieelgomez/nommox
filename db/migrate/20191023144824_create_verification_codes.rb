class CreateVerificationCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :verification_codes do |t|
      t.string :code
      t.string :phone

      t.timestamps
    end
  end
end
