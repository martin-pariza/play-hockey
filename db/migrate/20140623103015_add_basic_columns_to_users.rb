class AddBasicColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, limit: 50
    add_column :users, :lastname, :string, limit: 50
    add_column :users, :name_suffix, :string, limit: 10
    add_column :users, :year_of_birth, :date
    add_column :users, :residence, :string, limit: 100
    add_column :users, :phone_nr, :string, limit: 20
  end
end
