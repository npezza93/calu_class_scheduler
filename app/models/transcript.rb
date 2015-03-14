class Transcript < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  validates_uniqueness_of :course, scope: :user
  
  validates :course, presence: true
  
    def self.import(file, u_id)
      reader = PDF::Reader.new(file.path)
      courses = []
      pdf_pages = reader.pages.collect { |page| page.text }
      page_lines = pdf_pages.join("").split("\n\n\n").collect { |lines| lines.split("\n\n") }
      page_lines.flatten!
      # page_lines.reject! { |line| line.empty? }
      
      start_line = 0
      page_lines.each_with_index do |line, index|
          if line.include?"Classification"
            User.find(u_id).update(class_standing: line.split()[(line.split().index "Classification")+1].gsub(/[^\w-]/, '-').split("--")[0])
          end
          if line.include?"SAT" and line.include?"Mathematics"
            score = (line.split.select { |element| element.include? "Mathematics" })[0].gsub(/[^\w-]/, '-').split("---")[1].to_i
            if score >= 520
              User.find(u_id).update(sat_520: true)
              if score >= 580
                User.find(u_id).update(sat_580: true)
              else
                User.find(u_id).update(sat_580: false)
              end
            else
              User.find(u_id).update(sat_520: false, sat_580: false)
            end
          end
          if line.strip.downcase.include? "spring" or line.strip.downcase.include? "fall"
            start_line = index
            break
          end
      end
      
      page_lines = page_lines.drop(start_line+1)
      page_lines.each_with_index do |line, index|
          t_line = (line.split("    ")).reject! { |el| el.empty? }
          if t_line 
            t_line.collect! {|el| el.split("\n") }
            t_line.flatten!
            t_line.delete("\n") 
            if t_line.length == 5
              if t_line[0].strip.length == 3
                courses << [t_line[0].strip, t_line[1].strip, t_line[3].strip]
              else
                courses << [t_line[3].strip, t_line[4].strip, t_line[1].strip]
              end
            elsif t_line.length == 6
              if t_line[5].strip.length == 3
                courses << [t_line[4].strip, t_line[5].strip, t_line[2].strip]
              else
                courses << [t_line[3].strip, t_line[4].strip, t_line[1].strip]
              end
            elsif  t_line.length == 10
              if t_line[0].strip.length == 3
                courses << [t_line[0].strip, t_line[1].strip, t_line[3].strip]
              else
                courses << [t_line[3].strip, t_line[4].strip, t_line[1].strip]
              end
              if t_line[5].strip.length == 3
                courses << [t_line[5].strip, t_line[6].strip, t_line[8].strip]
              else
                courses << [t_line[8].strip, t_line[9].strip, t_line[6].strip]
              end              
              
            end
          end
      end
      
      bad_courses = []
      courses.each do |row|
        if !row[2].downcase.include?"reg"
          if Course.where(subject: row[0], course: row[1]).exists?
            c_id = Course.where(subject: row[0], course: row[1]).take.id
            c_minus, c = self.grade_check(row[2])
            transcript = Transcript.where(user_id: u_id, course_id: c_id)
            
            if transcript.exists?
              transcript = transcript.take.update(grade_c_minus: c_minus, grade_c: c)
            else
              Transcript.create(user_id: u_id, course_id: c_id, grade_c_minus: c_minus, grade_c: c)
            end
          else
            bad_courses << row
          end
        end
      end  
      return bad_courses
    end
    
    def self.grade_check(grade)
      grades = ["A","A-", "B+", "B", "B-", "C+", "C","C-", "D-","D","D+", "F"]
      if grade[0].downcase == "t"
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
