class Offering < ActiveRecord::Base
  belongs_to :days_time
  belongs_to :user
  belongs_to :course
  belongs_to :semester

  before_save :default_semester

  validates :course,
            uniqueness: { scope: [:days_time, :user],
                          message: 'This is already being offered!'
                        }

  validates :course, presence: { message: 'A course must be selected!' }
  validates :days_time, presence: true
  validates :user, presence: true
  validates :section, presence: true

  def self.import(file)
    CSV.foreach(file.path) do |row|
      course   = Course.csv_get_course(row)
      prof     = Course.csv_get_prof(row)
      day_time = Course.csv_get_day_time(row)
      offering = Offering.new(user: prof, days_time: day_time,
                              course: course, section: row[2])
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
    if prof[1].nil?
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
      Course.csv_get_offsite(row)
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
    if row[2][0].casecmp('w')
      DaysTime.find_by('days = ?', 'ONLINE')
    elsif row[2][0].casecmp('x')
      DaysTime.find_by('days = ?', 'OFFSITE')
    end
  end

  private

  def default_semester
    self.semester = Semester.where(active: true).take
  end
end
