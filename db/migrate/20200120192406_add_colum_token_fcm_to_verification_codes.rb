class AddColumTokenFcmToVerificationCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :verification_codes, :token_fcm, :string
  end
end
