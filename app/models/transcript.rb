class Transcript < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  validates_uniqueness_of :course, scope: :user
  
  validates :course, presence: true
  
    def self.import(file, u_id)
      reader = PDF::Reader.new(file.path)
      courses = []
      pdf_pages = reader.pages.collect { |page| page.text }
      page_lines = (pdf_pages.collect { |page| page.split("\n\n") }).flatten!
      page_lines.reject! { |line| line.empty? }
      
      start_line = 0
      page_lines.each_with_index do |line, index|
          if line.strip.downcase.include? "spring" or line.strip.downcase.include? "fall"
              start_line = index
              break
          end
      end
      
      page_lines = page_lines.drop(start_line+1)
      page_lines.each do |line|
          t_line = line.split()
          if t_line[0].length == 3
              courses << [t_line[0], t_line[1], t_line[3]]
          elsif t_line.length == 5
              courses << [t_line[3], t_line[4], t_line[1]]
          elsif t_line.length == 10
              courses << [t_line[3], t_line[4], t_line[1]]
              courses << [t_line[8], t_line[9], t_line[6]]
          elsif t_line[0].downcase.include? "spring" or t_line[0].downcase.include? "fall"
              courses << [t_line[4], t_line[5], t_line[2]]
          end
      end
      
      courses.each do |course|
          course.compact!
      end
      courses.reject! { |course| course.empty? }
      
      bad_courses = []
      courses.each do |row|
        if row[2].strip.downcase != "reg "
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
