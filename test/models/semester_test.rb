# frozen_string_literal: true

# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  semester   :string(255)
#  active     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

require "test_helper"

class SemesterTest < ActiveSupport::TestCase
end
