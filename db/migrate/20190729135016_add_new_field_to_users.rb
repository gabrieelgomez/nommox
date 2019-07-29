class AddNewFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name,     :string
    add_column :users, :phone,    :string
    add_column :users, :country,  :string
    add_column :users, :province, :string
    add_column :users, :city,     :string
  end
end
