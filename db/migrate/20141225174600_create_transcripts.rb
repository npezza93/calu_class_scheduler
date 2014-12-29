class CreateTranscripts < ActiveRecord::Migration
  def change
    create_table :transcripts do |t|
      t.references :user, index: true
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
