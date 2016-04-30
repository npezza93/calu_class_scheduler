class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :offerings, :course_id
    add_index :offerings, :days_time_id
    add_index :prerequisites, :course_id
    add_index :prerequisites, :prerequisite_group_id
  end
end
