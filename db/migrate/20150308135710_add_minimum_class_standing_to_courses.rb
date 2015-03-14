class AddMinimumClassStandingToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :minimum_class_standing, :string
  end
end
