class CreateMatchSubscriptions < ActiveRecord::Migration
  def change
    create_table :match_subscriptions do |t|
      t.integer :user_id
      t.integer :match_id

      t.timestamps
    end
  end
end
