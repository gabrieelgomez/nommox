class AddNewFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name,                     :string
    add_column :users, :phone,                    :string
    add_column :users, :country_id,               :string
    add_column :users, :province_id,              :string
    add_column :users, :city_id,                  :string
    add_column :users, :identification_document,  :string
    add_column :users, :passport,                 :string
    add_column :users, :firm,                     :string
    add_column :users, :video,                    :string
  end
end
