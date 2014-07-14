class RenameCategoryToCategoryId < ActiveRecord::Migration
  def change
    rename_column :matches, :category, :category_id
  end
end
