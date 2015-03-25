class AddSat440ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sat_440, :boolean
  end
end