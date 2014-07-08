class CancelDefaultValue < ActiveRecord::Migration
  def change
    change_column :matches, :max_num_of_players, :integer, default: nil
  end
end
