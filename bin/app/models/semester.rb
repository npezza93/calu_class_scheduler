class Semester < ActiveRecord::Base
    validates :semester, uniqueness: true, presence: true
end
