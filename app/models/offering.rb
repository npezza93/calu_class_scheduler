class Offering < ActiveRecord::Base
    belongs_to :days_time
    belongs_to :user
    belongs_to :course

    validates_uniqueness_of :course, scope: [:days_time, :user]
  
    validates :course, presence: true
    validates :days_time, presence: true
    validates :user, presence: true

    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        class_id = Course.where("subject = ? AND course = ?",row["subject"].upcase,row["course"].to_i).take.id
        instructor_id = User.where("email = ?", row["advisor"]).take.id
        day_time_id = DaysTime.where("days = ? AND start_time = ? and end_time = ? ", row["days"], row["start_time"], row["end_time"]).take.id

        offering = Offering.new do |o|
          o.user_id      = instructor_id
          o.course_id    = class_id
          o.days_time_id = day_time_id
        end
        offering.save
      end      
    end
end
