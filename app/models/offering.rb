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

    def self.import(file)
      CSV.foreach(file.path) do |row|
        begin
          course = Course.where("subject = ? AND course = ?",row[1].split()[0].upcase, row[1].split()[1].to_i).take
          prof = User.where("lower(last_name) = ? AND lower(first_name) = ?", row[12].split(",")[0].strip.downcase, ((row[12].split(",")[1] == nil) ? nil :  row[12].split(",")[1].strip.downcase)).take
          if row[7].blank?
            if row[2][0].upcase == "W"
              day_time = DaysTime.where("days = ?", "ONLINE").take
            elsif row[2][0].upcase == "X"
              day_time = DaysTime.where("days = ?", "OFFSITE").take
            end
          else
            day_time = DaysTime.where("days = ? AND start_time = ? and end_time = ? ", row[7].upcase, Time.strptime(row[8],"%I%M%p").strftime("%-l:%M %P"), Time.strptime(row[9],"%I%M%p").strftime("%-l:%M %P")).take
          end
          
          offering = Offering.create(user: prof, days_time: day_time, course: course, section: row[2])
      
        rescue
        end
      end 
    end
    
    private
      def default_semester
        self.semester = Semester.where(active: true).take
      end
end