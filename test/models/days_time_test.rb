# frozen_string_literal: true

# == Schema Information
#
# Table name: days_times
#
#  id         :integer          not null, primary key
#  days       :string(255)
#  start_time :datetime
#  end_time   :datetime
#  created_at :datetime
#  updated_at :datetime
#

require "test_helper"

class DaysTimeTest < ActiveSupport::TestCase
end
