# frozen_string_literal: true
class AddCompletedToUserCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :user_categories, :completed, :boolean
  end
end
