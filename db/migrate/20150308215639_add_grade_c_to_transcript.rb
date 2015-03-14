class AddGradeCToTranscript < ActiveRecord::Migration
  def change
    add_column :transcripts, :grade_c, :boolean
  end
end
