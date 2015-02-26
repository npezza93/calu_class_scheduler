class AddCountToCurriculumCategorySets < ActiveRecord::Migration
  def change
    add_column :curriculum_category_sets, :count, :integer
  end
end
