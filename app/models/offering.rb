class ClassOverlapOfferingValidator < ActiveModel::Validator
  def validate(offering)
    
    user = offering.user_id
    if offering.days_time_id != -1
      start_time_in_q = Time.strptime(offering.days_time.start_time, "%l:%M %P")
      end_time_in_q = Time.strptime(offering.days_time.end_time, "%l:%M %P")
  
      days_in_q = offering.days_time.days
      
      day_time_ar = Offering.where(user_id: user).find_each.collect { |s| [s.days_time.days, s.days_time.start_time, s.days_time.end_time] }
    
      day_time_ar.each do |off_time|
        start_off_time = Time.strptime(off_time[1], "%l:%M %P")
        end_off_time = Time.strptime(off_time[2], "%l:%M %P")
  
        if days_in_q == off_time[0]
          if (start_time_in_q <= end_off_time and start_off_time <=end_time_in_q) 
            offering.errors[:Instructors] << 'cannot teach two classes at the same time'
          end
        end
      end
    end
  end
end

class Offering < ActiveRecord::Base
    belongs_to :days_time
    belongs_to :user
    belongs_to :course
    belongs_to :semester
    
    before_save :default_semester
    
    validates_uniqueness_of :course, scope: [:days_time, :user]
  
    validates :course, presence: true
    validates :days_time, presence: true
    validates :user, presence: true
    validates_with ClassOverlapOfferingValidator
    
    def self.import(file)
      CSV.foreach(file.path) do |row|
        course_id = prof_id = day_time_id = nil
        
        begin
          course_id = Course.where("subject = ? AND course = ?",row[1].split()[0].upcase, row[1].split()[1].to_i).take.id
          prof_id = User.where("email = ?", row[12].split()[0][0..-2].downcase + '@calu.edu').take.id
          day_time_id = DaysTime.where("days = ? AND start_time = ? and end_time = ? ", row[7].upcase, Time.strptime(row[8], "%I%M%P").strftime("%l:%M %P").strip, Time.strptime(row[9], "%I%M%P").strftime("%l:%M %P").strip).take.id

          offering = Offering.new do |o|
            o.user_id      = prof_id
            o.course_id    = course_id
            o.days_time_id = day_time_id
            o.section      = row[2]
          end
          offering.save
        rescue
        end
      end 
    end
    
    private
      def default_semester
        self.semester = Semester.where(active: true).take
      end
end