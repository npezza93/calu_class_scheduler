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
  belongs_to :days_time
  belongs_to :user
  belongs_to :course
  belongs_to :semester

  before_save :default_semester

  validates :course, uniqueness: {
    scope: [:days_time, :user, :semester_id],
    message: "This is already being offered!"
  }
  validates :course, presence: { message: "A course must be selected!" }
  validates :days_time, presence: { message: "A time slot must be selected!" }
  validates :user, presence: { message: "A professor must be selected!" }
  validates :section, presence: true

  scope :for_semester, lambda { |semester = Semester.active|
    where(semester: semester)
  }

  def display
    "#{days_time.days} from #{display_time} with #{user.professor}"
  end

  def display_time
    return if days_time.start_time.blank?

    days_time.start_time.split(" ")[0] + "-" + days_time.end_time
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
          days: row[7].upcase,
          start_time: Time.strptime(row[8], "%I%M%p").strftime("%-l:%M %P"),
          end_time: Time.strptime(row[9], "%I%M%p").strftime("%-l:%M %P")
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
  end

  private

  def default_semester
    self.semester = Semester.active
  end
end
