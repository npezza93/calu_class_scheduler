class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :courses, :required, :core
  end
end
