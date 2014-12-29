class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
