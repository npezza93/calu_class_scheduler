class AddMinorToCurriculumCategories < ActiveRecord::Migration
  def change
    add_column :curriculum_categories, :minor, :boolean
  end
end
