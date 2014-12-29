class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.belongs_to :course
      t.belongs_to :days_time

      t.timestamps
    end
  end
end
