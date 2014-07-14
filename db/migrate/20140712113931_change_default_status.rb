class ChangeDefaultStatus < ActiveRecord::Migration
  def change
    change_column :users, :status_id, :integer, default: 1
  end
end
