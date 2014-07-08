class AddPlaysSinceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plays_since, :integer
  end
end
