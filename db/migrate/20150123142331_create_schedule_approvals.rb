class CreateScheduleApprovals < ActiveRecord::Migration
  def change
    create_table :schedule_approvals do |t|
      t.belongs_to :user, index: true
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
