class ChangeYearOfBirthToInt < ActiveRecord::Migration
  def change
    change_column :users, :year_of_birth, :integer
  end
end
