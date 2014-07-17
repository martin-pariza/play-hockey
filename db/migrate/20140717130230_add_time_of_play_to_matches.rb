class AddTimeOfPlayToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :time_of_play, :time
  end
end
