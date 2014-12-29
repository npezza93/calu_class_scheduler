class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites, id: false do |t|
      t.integer :parent_course_id
      t.integer :prerequisite_course_id

      t.timestamps
    end
  end
end