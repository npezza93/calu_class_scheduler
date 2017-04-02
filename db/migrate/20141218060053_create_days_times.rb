# frozen_string_literal: true

class CreateDaysTimes < ActiveRecord::Migration
  def change
    create_table :days_times do |t|
      t.string :days
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
