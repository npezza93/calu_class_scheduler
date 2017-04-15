# frozen_string_literal: true

class AddStartOnAndEndOnToSemesters < ActiveRecord::Migration[5.1]
  def change
    add_column :semesters, :start_on, :date
    add_column :semesters, :end_on, :date
    remove_column :semesters, :active
  end
end
