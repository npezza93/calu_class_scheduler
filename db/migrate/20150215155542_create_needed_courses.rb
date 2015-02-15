class CreateNeededCourses < ActiveRecord::Migration
  def change
    create_table :needed_courses do |t|
      t.belongs_to :course, index: true
      t.belongs_to :user, index: true
      t.belongs_to :semester, index: true

      t.timestamps
    end
  end
end
