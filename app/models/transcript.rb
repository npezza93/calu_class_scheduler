class Transcript < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  validates_uniqueness_of :course, scope: :user
  
  validates :course, presence: true
  
    def self.import(file, u_id)
      file = file.split /[\r\n]+/
      file.reject! { |c| c.empty? }
      
      if file[0].downcase == "california university degreeworks"
        class_standing = ""
        sat_math = 0
        main_line = 0
        
        file.each_with_index do |line, index|
        	split_line = line.split()
        	if split_line[0] != nil
        		if split_line[0].strip.downcase == "classification"
        			class_standing = split_line[1]
        		end
        
        		if split_line[0].strip.downcase == "sat" and split_line[1].downcase == "mathematics"
        			sat_math = split_line[3].to_i
        		end	
        
        		if split_line[0].strip.downcase == "spring" or split_line[0].strip.downcase == "fall"
        			main_line = index
        			break
        		end
        	end
        end
        
        User.find(u_id).update(class_standing: class_standing)
        case sat_math
        when 700..800
          User.find(u_id).update(sat_520: true, sat_580: true, sat_440: true, sat_640: true, sat_700: true)
        when 640..699
          User.find(u_id).update(sat_520: true, sat_580: true, sat_440: true, sat_640: true, sat_700: false)
        when 580..639
          User.find(u_id).update(sat_520: true, sat_580: true, sat_440: true, sat_640: false, sat_700: false)
        when 520..579
          User.find(u_id).update(sat_520: true, sat_580: false, sat_440: true, sat_640: false, sat_700: false)
        when 440..519
          User.find(u_id).update(sat_520: false, sat_580: false, sat_440: true, sat_640: false, sat_700: false)
        else
          User.find(u_id).update(sat_520: false, sat_580: false, sat_440: false, sat_640: false, sat_700: false)
        end
        
        file = file.drop(main_line+1)
        courses = []
        
        file.each_with_index do |line, index|
        	line = line.split("\t")
        	if line.length == 5
        		courses << [line[0].strip, line[1].strip.to_i,line[3].strip]
        	end
        end
  
        all_courses = Course.all
        transcripts = User.includes(:transcripts).find(u_id).transcripts
        bad_courses = []
        courses.each do |row|
          if all_courses.where(subject: row[0], course: row[1]).exists? and row[2] != "w"
            c_id = all_courses.where(subject: row[0], course: row[1]).take.id
            c_minus, c = self.grade_check(row[2])

            if transcripts.where(user_id: u_id, course_id: c_id).exists?
              transcript = transcript.take.update(grade_c_minus: c_minus, grade_c: c)
            else
              Transcript.create(user_id: u_id, course_id: c_id, grade_c_minus: c_minus, grade_c: c)
            end
          else
            bad_courses << row
          end
        end
      else
        return nil
      end
      return bad_courses
    end
    
    def self.grade_check(grade)
      grades = ["A","A-", "B+", "B", "B-", "C+", "C","C-", "D-","D","D+", "F"]
      if grade[0].downcase == "t" or grade.downcase.include?"reg" or grade.downcase.include?"p"
        c_minus = true
        c = true
      else
        begin
          if grades.index(grade) >= 8
            c_minus = c = false
          else
            if grades.index(grade) <= 6
              c_minus = c = true
            elsif grades.index(grade) == 7
              c = false
              c_minus = true
            end
          end
        rescue
          c_minus = c = false
        end
      end
      return c_minus, c
    end
end
