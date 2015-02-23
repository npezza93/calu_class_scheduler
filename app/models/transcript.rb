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
      page_lines.reject! { |line| line.empty? }
      
      start_line = 0
      page_lines.each_with_index do |line, index|
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
            end
          end
      end
      
      bad_courses = []
      courses.each do |row|
        if !row[2].downcase.include?"reg"
          if Course.where(subject: row[0], course: row[1]).exists?
            c_id = Course.where(subject: row[0], course: row[1]).take.id
            transcript = Transcript.find_or_create_by(user_id: u_id, course_id: c_id, grade: row[2])
          else
            bad_courses << row
          end
        end
      end  
      return bad_courses
    end
end
