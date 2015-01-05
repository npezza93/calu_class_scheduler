class DropCurriculums < ActiveRecord::Migration
  def up
    drop_table :curriculums
  end

  def down
    create_table :curriculums do |t|
      t.belongs_to :course, index: true

      t.timestamps        
    end
  end
end
