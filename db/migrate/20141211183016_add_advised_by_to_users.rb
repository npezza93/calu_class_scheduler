class AddAdvisedByToUsers < ActiveRecord::Migration
  def change
    add_column :users, :advised_by, :integer
  end
end
