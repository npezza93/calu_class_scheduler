class Course < ActiveRecord::Base
  has_many :prerequisites, :class_name => 'Prerequisites', :foreign_key => 'parent_course_id'
  validates :title, presence: true
  validates :subject, presence: true
  validates :course, presence: true, numericality: { only_integer: true }
  validates :credits, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of :course, scope: [:subject]

  before_save :set_class_standing

  has_many :offerings
  
  def pretty_course
    self.subject + self.course.to_s + ": " + self.title
  end

  def self.cached_select_courses
    Rails.cache.fetch([name, "select_courses"]) { Course.all.order(:course).collect { |c| [c.pretty_course, c.id] } }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, "select_courses"])
  end

  private
    def set_class_standing
      if self.minimum_class_standing == "No minimum class standing"
        self.minimum_class_standing = nil
      end
    end
end
