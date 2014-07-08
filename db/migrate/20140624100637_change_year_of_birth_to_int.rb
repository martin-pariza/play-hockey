class ChangeYearOfBirthToInt < ActiveRecord::Migration
  def change
    change_column :users, :year_of_birth, 'integer USING CAST(year_of_birth AS integer)'
  end
end
