class AddCategoryToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :category, :integer, default: 1
    add_index :matches, :category
  end
end
