class AddLogicFlagToCurriculumCategory < ActiveRecord::Migration
  def change
    add_column :curriculum_categories, :logic_flag, :boolen, default: false
  end
end
