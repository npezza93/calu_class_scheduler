class AddSat700ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sat_700, :boolean
  end
end
