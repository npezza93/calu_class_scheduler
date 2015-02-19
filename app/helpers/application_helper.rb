module ApplicationHelper
    
    def create_day_hash(offerings)
      day_hash = {"Monday" => [],
                 "Tuesday"=> [],
                 "Wednesday"=> [],
                 "Thursday"=> [],
                 "Friday"=> []
                }
      offerings.each do |course|
        if course.days_time.days.include? "M"
          day_hash["Monday"] << course
        end
        if course.days_time.days.include? "T"
          day_hash["Tuesday"] << course
        end
        if course.days_time.days.include? "W"
          day_hash["Wednesday"] << course
        end
        if course.days_time.days.include? "R"
          day_hash["Thursday"] << course
        end
        if course.days_time.days.include? "F"
          day_hash["Friday"] << course
        end
      end
      return day_hash
    end
end
