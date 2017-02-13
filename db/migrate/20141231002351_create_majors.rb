# frozen_string_literal: true
class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :major

      t.timestamps
    end
  end
end
