# frozen_string_literal: true
class RemoveOldLoginFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest, :string
    remove_column :users, :password_reset_token, :string
    remove_column :users, :password_reset_sent_at, :string
  end
end
