class CreateCaseCauses < ActiveRecord::Migration[5.2]
  def change
    create_table :case_causes do |t|
      t.string :name

      t.timestamps
    end
  end
end
