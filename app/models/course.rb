class Course < ActiveRecord::Base
  has_many :prerequisites, :class_name => 'Prerequisites', :foreign_key => 'parent_course_id'
  validates :title, presence: true
  validates :subject, presence: true
  validates :course, presence: true, numericality: { only_integer: true }
  validates :credits, numericality: { only_integer: true }
  validates_uniqueness_of :course, scope: [:subject]
  
  before_save :set_class_standing

  private
    def set_class_standing
      if self.minimum_class_standing == "No minimum class standing"
        self.minimum_class_standing = nil
      end
    end
end