# frozen_string_literal: true

module Scheduler
  module CommitRecords
    def add_completed_to_db(courses, category: nil, schedules_category: nil)
      schedules_category ||= user.schedules_categories.where(
        curriculum_category_id: category.id, completed: true, semester: semester
      ).first_or_create

      Schedules::CategoryCourse.transaction do
        courses.each do |course|
          schedules_category.category_courses.create(course_id: course.id)
        end
      end
    end

    def add_incomplete_to_db(category, schedules_category)
      incomplete[category].each do |course|
        next unless course.is_a?(Course)

        capture_math_class(course, category)
        add_schedule_offering_from_course(schedules_category, course)
      end
    end

    def add_schedule_offering_from_course(schedules_category, course)
      offerings = course.offerings.select do |offering|
        offering.semester_id ==
          (semester.is_a?(Semester) ? semester.id : semester)
      end

      Schedules::CategoryOffering.transaction do
        offerings.each do |offering|
          schedules_category.category_offerings.create(offering_id: offering.id)
        end
      end
    end
  end
end
