class AddCaseStatusIdToCases < ActiveRecord::Migration[5.2]
  def change
    add_reference :cases, :case_status, foreign_key: true
  end
end
