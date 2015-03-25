class AddMinimumPtToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :minimum_pt, :string
  end
end
