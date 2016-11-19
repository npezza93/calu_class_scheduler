class Offering < ApplicationRecord
  belongs_to :days_time
  belongs_to :user
  belongs_to :course
  belongs_to :semester

  before_save :default_semester

  validates :course,
            uniqueness: {
                          scope: [:days_time, :user, :semester_id],
                          message: 'This is already being offered!'
                        }

  validates :course, presence: { message: 'A course must be selected!' }
  validates :days_time, presence: { message: 'A time slot must be selected!' }
  validates :user, presence: { message: 'A professor must be selected!' }
  validates :section, presence: true

  def display
    "#{days_time.days} from #{display_time} with #{user.professor}"
  end

  def display_time
    return if days_time.start_time.blank?

    days_time.start_time.split(' ')[0] + '-' + days_time.end_time
  end

  def self.search(search, page)
    if search.blank?
      includes(:course, :days_time, :user)
    else
      search = "%#{search}%"
      joins(:course, :days_time, :user).where(
        'LOWER(courses.title) LIKE ? OR LOWER(courses.subject) LIKE ? OR
         LOWER(days_times.days) LIKE ? OR
         LOWER(users.first_name) LIKE ? OR LOWER(users.last_name) LIKE ?',
        search, search, search, search, search
      )
    end.where(semester: Semester.active).page(page).per(20)
  end

  def self.import(file)
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
  def self.csv_get_course(row)
    subject = row[1].split[0].upcase
    course  = row[1].split[1].to_i
    Course.find_by('subject = ? AND course = ?', subject, course)
  end

  def self.csv_get_prof(row)
    prof = row[12].split(',')
    if prof[1].blank?
      User.find_by(first_name: nil)
    else
      last_name  = prof[0].strip.downcase
      first_name = prof[1].strip.downcase
      User.find_by('lower(last_name) = ? AND lower(first_name) = ?',
                   last_name, first_name)
    end
  end

  def self.csv_get_day_time(row)
    if row[7].blank?
      csv_get_offsite(row)
    else
      DaysTime.find_by(
        'days = ? AND start_time = ? and end_time = ? ',
        row[7].upcase,
        Time.strptime(row[8], '%I%M%p').strftime('%-l:%M %P'),
        Time.strptime(row[9], '%I%M%p').strftime('%-l:%M %P')
      )
    end
  end

  def self.csv_get_offsite(row)
    if row[2][0].casecmp('w').zero?
      DaysTime.find_by('days = ?', 'ONLINE')
    elsif row[2][0].casecmp('x').zero?
      DaysTime.find_by('days = ?', 'OFFSITE')
    end
  end

  private

  def default_semester
    self.semester = Semester.active
  end
end
