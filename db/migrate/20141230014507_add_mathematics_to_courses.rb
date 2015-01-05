class AddMathematicsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :mathematics, :boolean, default: false
  end
end
