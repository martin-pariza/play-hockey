class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.date :date_of_play
      t.string :name, limit: 100
      t.string :note, limit: 200
      t.integer :min_num_of_players
      t.integer :max_num_of_players, default: 12
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
