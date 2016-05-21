class AddIndexToMinorInCurriculumCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :curriculum_categories, :minor
  end
end
