# frozen_string_literal: true

class AddDescriptionToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :description, :text
  end
end
