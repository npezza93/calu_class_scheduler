# frozen_string_literal: true
require "test_helper"

class OfferingsTest < ActiveSupport::TestCase
  test "CSV upload" do
    @file = CSV.open("temp_offerings.csv", "w") do |csv|
      csv << [nil, "AAA 123 Course 1", "W1", nil, nil, nil, nil, "MWF",
              "0800AM", "0850AM", nil, nil, "advisor, advisor"]
    end

    assert_difference("Offering.count") do
      Offering.import @file
    end

    File.delete "temp_offerings.csv"
  end

  test "CSV upload no first name" do
    @file = CSV.open("temp_offerings.csv", "w") do |csv|
      csv << [nil, "AAA 123 Course 1", "W1", nil, nil, nil, nil, "MWF",
              "0800AM", "0850AM", nil, nil, "advisor,"]
    end

    assert_difference("Offering.count") do
      Offering.import @file
    end

    File.delete "temp_offerings.csv"
  end

  test "CSV upload, offsite" do
    @file = CSV.open("temp_offerings.csv", "w") do |csv|
      csv << [nil, "AAA 123 Course 1", "X1", nil, nil, nil, nil, nil,
              nil, nil, nil, nil, "advisor, advisor"]
    end

    assert_difference("Offering.count") do
      Offering.import @file
    end

    File.delete "temp_offerings.csv"
  end

  test "CSV upload, online" do
    @file = CSV.open("temp_offerings.csv", "w") do |csv|
      csv << [nil, "AAA 123 Course 1", "W1", nil, nil, nil, nil, nil,
              nil, nil, nil, nil, "advisor, advisor"]
    end

    assert_difference("Offering.count") do
      Offering.import @file
    end

    File.delete "temp_offerings.csv"
  end
end
