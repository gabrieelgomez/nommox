class AddCaseIdToCompanions < ActiveRecord::Migration[5.2]
  def change
    add_column :companions, :case_id, :string
  end
end
