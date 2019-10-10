class AddChannelSidToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :channel, :string
    add_column :activities, :token, :string
  end
end
