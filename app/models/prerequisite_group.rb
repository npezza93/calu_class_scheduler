class PrerequisiteGroup < ActiveRecord::Base
  has_many :prerequisites
  belongs_to :course
end
