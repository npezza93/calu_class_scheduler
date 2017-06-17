# frozen_string_literal: true

module UserDescriptorConstants
  extend ActiveSupport::Concern

  YEAR = {
    "Senior" => 1, "Junior" => 2, "Sophmore" => 3, "Freshman" => 4
  }.freeze

  PLACEMENT_TEST_PARTS = [
    ["No Part Must Be Passed", nil], ["Pass Part A", "A"],
    ["Pass Part B", "B"], ["Pass Part C", "C"],
    ["Pass Part D (7-9)", "D-"], ["Pass Part D (10 or above)", "D"]
  ].freeze

  CLASS_STANDINGS = [
    ["No minimum class standing", nil], %w(Senior Senior), %w(Junior Junior),
    %w(Sophmore Sophmore), %w(Freshman Freshman)
  ].freeze

  SAT_SCORES = [
    ["No minimum SAT score", nil], ["440 on Mathematics or better", "440"],
    ["520 on Mathematics or better", "520"],
    ["580 on Mathematics or better", "580"],
    ["640 on Mathematics or better", "640"],
    ["700 on Mathematics or better", "700"]
  ].freeze
end
