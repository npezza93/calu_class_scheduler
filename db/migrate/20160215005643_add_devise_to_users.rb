# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[4.2]
  class << self
    def up
      change_table(:users) do |t|
        ## Database authenticatable
        t.string :encrypted_password, null: false, default: ""

        ## Recoverable
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at

        ## Rememberable
        t.datetime :remember_created_at

        ## Trackable
        add_trackers(t)
        t.index :email,                unique: true
        t.index :reset_password_token, unique: true
      end
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end

    private

    def add_trackers(table)
      table.integer  :sign_in_count, default: 0, null: false
      table.datetime :current_sign_in_at
      table.datetime :last_sign_in_at
      table.inet     :current_sign_in_ip
      table.inet     :last_sign_in_ip
    end
  end
end
