class AddMajorToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :major, index: true
  end
end
