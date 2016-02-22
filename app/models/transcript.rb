class Transcript < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :course

  validates_uniqueness_of :course, scope: :user, message: 'You\'ve already taken this course!'

  validates_presence_of :course, message: 'A course must be selected!'


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
        new_transcripts = []
        courses = Course.all

        file.each_with_index do |line, index|
        	line = line.split("\t")
        	if line.length == 5
        		new_transcripts << [courses.where(subject: line[0].strip, course: line[1].strip.to_i).take, line[3].strip]
        	end
        end

        user = User.includes(:transcripts, :taken_courses).find(u_id)
        taken_courses = user.taken_courses
        transcripts = user.transcripts

        new_transcripts.each do |new_transcript|
          if new_transcript[1] != "w"
            c_minus, c = self.grade_check(new_transcript[1])

            if taken_courses.include? new_transcript[0]
              transcript = transcripts.where(course: new_transcript[0]).take.update(grade_c_minus: c_minus, grade_c: c)
            else
              transcript = user.transcripts.new(course: new_transcript[0], grade_c_minus: c_minus, grade_c: c)
              transcript.save
            end
          end
        end
      else
        return nil
      end
    end

    def self.grade_check(grade)
      grades = %w(A A- B+ B B- C+ C C- D- D D+ F)
      if grade[0].casecmp('t') || grade.downcase.include?('reg') || grade.downcase.include?('p')
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
