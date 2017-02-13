# frozen_string_literal: true
class TruncatePrerequisites < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute("TRUNCATE prerequisites")
  end
end
