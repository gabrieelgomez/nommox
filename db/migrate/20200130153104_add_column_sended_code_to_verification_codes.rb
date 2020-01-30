class AddColumnSendedCodeToVerificationCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :verification_codes, :sended_code, :boolean, default: false    
  end
end
