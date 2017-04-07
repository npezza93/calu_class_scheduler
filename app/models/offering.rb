# frozen_string_literal: true

# == Schema Information
#
# Table name: offerings
#
#  id           :integer          not null, primary key
#  course_id    :integer
#  days_time_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  semester_id  :integer
#  section      :string(255)
#

class Offering < ApplicationRecord
  include SemesterHelpers

  belongs_to :days_time
  belongs_to :user
  belongs_to :course

  validates :course, uniqueness: {
    scope: %i(days_time user semester_id),
    message: "This is already being offered!"
  }
  validates :course, presence: { message: "A course must be selected!" }
  validates :days_time, presence: { message: "A time slot must be selected!" }
  validates :user, presence: { message: "A professor must be selected!" }
  validates :section, presence: true

  scope :has_meeting_time, lambda {
    joins(:days_time).merge(DaysTime.has_meeting_time)
  }

  delegate :time_range, :meeting_time?, :days, :overlaps?, to: :days_time

  def display
    "#{days_time.days} from #{display_time} with #{user.professor}"
  end

  def display_time
    return if days_time.start_time.blank?

    days_time.start_time.strftime("%l:%M") + " -" +
      days_time.end_time.strftime("%l:%M")
  end

  class << self
    def import(file)
      CSV.foreach(file.path) do |row|
        course   = csv_get_course(row)
        prof     = csv_get_prof(row)
        day_time = csv_get_day_time(row)
        offering = new(user: prof, days_time: day_time, course: course,
                       section: row[2])
        offering.save if offering.valid?
      end
    end

    # CSV parse helper methods
    def csv_get_course(row)
      Course.find_by(
        subject: row[1].split[0].upcase, course: row[1].split[1].to_i
      )
    end

    def csv_get_prof(row)
      prof = row[12].split(",")
      if prof[1].blank?
        User.find_by(first_name: nil)
      else
        last_name  = prof[0].strip.downcase
        first_name = prof[1].strip.downcase
        User.find_by("lower(last_name) = ? AND lower(first_name) = ?",
                     last_name, first_name)
      end
    end

    def csv_get_day_time(row)
      if row[7].blank?
        csv_get_offsite(row)
      else
        DaysTime.find_by(
          days: row[7].upcase, start_time: convert_to_time(row[8]),
          end_time: convert_to_time(row[9]),
        )
      end
    end

    def csv_get_offsite(row)
      if row[2][0].casecmp("w").zero?
        DaysTime.find_by(days: "ONLINE")
      elsif row[2][0].casecmp("x").zero?
        DaysTime.find_by(days: "OFFSITE")
      end
    end

    def convert_to_time(time)
      Time.strptime("2001-01-01 #{time} +0000", "%Y-%m-%d %I%M%p %z")
    end
  end
end
