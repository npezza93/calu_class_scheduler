# frozen_string_literal: true
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
    def search_courses(query, page)
      course_ids = Offering.where(semester: Semester.active).pluck(:course_id)
      courses = Course.where(id: course_ids).distinct
      if query.present?
        query = "%#{query}%"
        courses = courses.where(
          "courses.title ILIKE ? OR courses.subject ILIKE ?",
          "%#{query}%", "%#{query}%"
        )
      end

      courses.order(:subject).page(page).per(20)
    end

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

    private

    def search_query
      "LOWER(courses.title) LIKE ? OR LOWER(courses.subject) LIKE ?"
    end
  end

  private

  def default_semester
    self.semester = Semester.active
  end
end
