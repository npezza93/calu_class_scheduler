class Major < ActiveRecord::Base
    validates :major, uniqueness: true, presence: true
end
