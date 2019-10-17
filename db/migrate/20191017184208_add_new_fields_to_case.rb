class AddNewFieldsToCase < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :delayReason, :string
    add_column :cases, :cancelTime, :string
    add_column :cases, :overbookingBenefit, :string
    add_column :cases, :baggageProblem, :string
    add_column :cases, :claimForm, :string
    add_column :cases, :bills, :string
    add_column :cases, :baggageBills, :string
    add_column :cases, :baggageDate, :string
    add_column :cases, :belongingsValue, :string
    add_column :cases, :valueStatement, :string
  end
end
