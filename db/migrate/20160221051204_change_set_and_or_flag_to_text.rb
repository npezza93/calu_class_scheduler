class ChangeSetAndOrFlagToText < ActiveRecord::Migration
  def change
    change_column(:curriculum_categories, :set_and_or_flag, :string)
  end
end
