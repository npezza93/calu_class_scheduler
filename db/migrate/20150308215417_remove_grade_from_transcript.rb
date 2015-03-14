class RemoveGradeFromTranscript < ActiveRecord::Migration
  def change
    remove_column :transcripts, :grade, :string
  end
end
