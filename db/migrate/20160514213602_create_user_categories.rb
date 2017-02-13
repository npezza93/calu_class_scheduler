# frozen_string_literal: true
class CreateUserCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :user_categories do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :curriculum_category, foreign_key: true

      t.timestamps
    end
  end
end
