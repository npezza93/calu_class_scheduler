class CreatePrerequisiteGroups < ActiveRecord::Migration
  def change
    create_table :prerequisite_groups do |t|
      t.belongs_to :course, index: true

      t.timestamps null: false
    end
  end
end
