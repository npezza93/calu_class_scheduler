class Major < ActiveRecord::Base
  validates :major, uniqueness: true, presence: true

  has_many :major_categories, -> { where minor: false },
           class_name: 'CurriculumCategory'

  has_many :minor_categories, -> { where minor: true },
           class_name: 'CurriculumCategory'
end
