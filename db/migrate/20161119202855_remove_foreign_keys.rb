class RemoveForeignKeys < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key "user_categories", "curriculum_categories"
    remove_foreign_key "user_categories", "users"
    remove_foreign_key "user_category_courses", "courses"
    remove_foreign_key "user_category_courses", "user_categories"
  end
end
