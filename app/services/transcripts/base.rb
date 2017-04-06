# frozen_string_literal: true

class Transcripts
  class Base
    attr_accessor :transcript, :user, :semester_id
    delegate :new_record?, :destroyed?, to: :transcript

    def initialize(transcript, user, semester_id)
      @transcript    = transcript
      @user          = user
      @semester_id   = semester_id
    end

    def offering_overlap?(offering, work_schedule)
      offering.meeting_time? &&
        offering.days.split("").include?(work_schedule.day) &&
        offering.time_range.overlaps?(work_schedule.time_range)
    end

    def hide_schedules_category_offerings
      schedules_categories.reload.each do |category|
        category.category_offerings.each do |category_offering|
          user.work_schedules.each do |work_schedule|
            if offering_overlap?(category_offering.offering, work_schedule)
              category_offering.update(hidden: true)
            end
          end
        end
      end
    end
  end
end
