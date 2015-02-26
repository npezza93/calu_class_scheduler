class AddSetAndOrFlagToCurriculumCategory < ActiveRecord::Migration
  def change
    add_column :curriculum_categories, :set_and_or_flag, :boolean
  end
end
