# frozen_string_literal: true

# == Schema Information
#
# Table name: work_days_times
#
#  id         :integer          not null, primary key
#  days       :string(255)
#  start_time :time
#  end_time   :time
#  created_at :datetime
#  updated_at :datetime
#

class WorkDaysTime < ApplicationRecord
end
