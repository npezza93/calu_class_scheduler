# frozen_string_literal: true

module SemesterHelpers
  extend ActiveSupport::Concern

  included do
    belongs_to :semester

    scope :for_semester, ->(semester) { where(semester: semester) }
  end

  class_methods do
    def for_semester_a(semester)
      semester = semester.id if semester.is_a?(Semester)

      all.select do |offering|
        offering.semester_id == semester
      end
    end
  end
end
