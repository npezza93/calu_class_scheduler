# frozen_string_literal: true
class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :semester
      t.boolean :active, default: false
      
      t.timestamps
    end
  end
end
