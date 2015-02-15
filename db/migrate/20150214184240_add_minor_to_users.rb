class AddMinorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :minor, :text
  end
end
