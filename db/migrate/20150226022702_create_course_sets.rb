class CreateCourseSets < ActiveRecord::Migration
  def change
    create_table :course_sets do |t|
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
