# frozen_string_literal: true
class AddCompletedToUserCategoryCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :user_category_courses, :completed, :boolean
  end
end
