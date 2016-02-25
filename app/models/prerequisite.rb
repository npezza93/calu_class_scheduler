class Prerequisite < ActiveRecord::Base
  belongs_to :prerequisite_group
  belongs_to :course

  validates :course, uniqueness: { scope: :prerequisite_group_id }
end
