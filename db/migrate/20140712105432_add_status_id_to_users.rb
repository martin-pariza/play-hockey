class AddStatusIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status_id, :integer, default: 0
  end
end
