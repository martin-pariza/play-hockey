class ChangeYearOfBirthToInt < ActiveRecord::Migration
  def change
    remove_column :users, :year_of_birth
    add_column :users, :year_of_birth, :integer
  end
end
