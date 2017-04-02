# frozen_string_literal: true

class CreatePrerequisiteGroups < ActiveRecord::Migration[4.2]
  def change
    create_table :prerequisite_groups do |t|
      t.belongs_to :course, index: true

      t.timestamps null: false
    end
  end
end
