class User < ApplicationRecord
  include Scheduler::CategorySets
  include Scheduler::CompleteCategory
  include Scheduler::IncompleteCategory
  include Scheduler::IncompleteOrCategory
  include Scheduler::Instances
  include Scheduler::MathClasses

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true
  validates :major, presence: true
  validates :advised_by, presence: true, if: "!advisor"
  validates :email, uniqueness: true
  validates :email, format: { with: Devise.email_regexp }

  belongs_to :major
  belongs_to :advisor_prof, class_name: "User", foreign_key: :advised_by
  has_one :schedule_approval, -> { where(semester: Semester.active) }
  has_many :transcripts
  has_many :taken_courses, through: :transcripts, source: :course
  has_many :schedules, -> { where(semester: Semester.active) }
  has_many :offerings, through: :schedules
  has_many :offering_day_times, through: :offerings, source: :days_time
  has_many :courses, through: :offerings
  has_many :work_schedules, -> { where(semester: Semester.active) }
  has_many :work_days_times, through: :work_schedules
  has_many :user_categories
  has_many :available_offerings,
           -> { where("user_category_courses.completed = ?", false) },
           class_name: "Offering", through: :user_categories, source: :offerings

  scope :offering_advisors, lambda {
    where("advisor = ? OR email = ?", true, "staff@calu.edu")
  }

  serialize :minor, Array

  before_validation do |model|
    model.minor&.reject!(&:blank?)
  end

  def name
    first_name + " " + last_name
  end

  def professor
    if !first_name.blank?
      "#{first_name[0].capitalize}. "
    else
      ""
    end + last_name.capitalize
  end

  def advisees
    User.includes(:courses).where(advised_by: self)
  end

  def students
    User.includes(:courses).where(advisor: false, administrator: false)
        .where.not(advised_by: self)
  end

  def credits
    courses.sum(&:credits)
  end

  def scheduler
    categories.each do |category|
      complete[category] = {}
      incomplete[category] = {}
      sets = category_sets(category)

      if category.complete?(sets)
        complete_category(category, sets.index(true))
      else
        incomplete_category(category)
      end
    end

    # add_needed_math_classes
  end

  def offerings_that_overlap
    available = available_offerings.includes(:days_time)

    taking = offerings.includes(:days_time)
    taking_course_ids = offerings.pluck(:course_id)

    available -= taking
    taking = taking.collect(&:days_time) + work_days_times
    return [] if taking.empty?

    offering_ids = available.select do |offering|
      offering.days_time.overlaps_any?(taking) ||
        taking_course_ids.include?(offering.course_id)
    end

    offering_ids.pluck(:id)
  end

  def self.search(user, search = nil)
    if search.blank?
      user.advisees + user.students
    else
      query = search.downcase
      where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?
             OR LOWER(email) LIKE ?",
            "%#{query}%", "%#{query}%", "%#{query}%")
        .where(advisor: false, administrator: false)
    end
  end
end
