class Curriculum < ActiveRecord::Base
  belongs_to :course
  
  validates :course, uniqueness: true
end
