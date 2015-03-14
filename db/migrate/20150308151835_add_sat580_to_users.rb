class AddSat580ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sat_580, :boolean
  end
end
