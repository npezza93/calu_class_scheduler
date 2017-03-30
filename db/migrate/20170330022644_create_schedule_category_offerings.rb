class CreateScheduleCategoryOfferings < ActiveRecord::Migration[5.1]
  def change
    create_table :schedule_category_offerings do |t|
      t.belongs_to :offering
      t.belongs_to :category
      t.boolean    :hidden, default: false

      t.timestamps
    end
  end
end
