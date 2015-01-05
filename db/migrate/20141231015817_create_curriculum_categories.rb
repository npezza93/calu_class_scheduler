class CreateCurriculumCategories < ActiveRecord::Migration
  def change
    create_table :curriculum_categories do |t|
      t.string :category
      t.integer :required_amount_of_credits
      t.belongs_to :major, index: true

      t.timestamps
    end
  end
end
