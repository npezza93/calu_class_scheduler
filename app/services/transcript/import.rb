# frozen_string_literal: true
class Transcript
  class Import
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def perform(text)
      text = text&.split(/[\r\n]+/)&.reject(&:empty?)

      return nil if text.blank? ||
                    text[0].casecmp("DegreeWorks: New Production") == -1
      update_sat_scores(text)
      parsed_transcripts = parse_courses(text.drop(main_line(text)), Course.all)

      update_transcripts(parsed_transcripts)
    end

    def update_sat_scores(text)
      math_sat_score = sat_info(text)

      user.update(
        sat_520: math_sat_score >= 520,
        sat_580: math_sat_score >= 580,
        sat_440: math_sat_score >= 440,
        sat_640: math_sat_score >= 640,
        sat_700: math_sat_score >= 700
      )
    end

    def sat_info(text)
      text.each do |line|
        first = line.split[0].strip
        second = line.split[1]
        next if first.nil?

        user.update(class_standing: second) if first =~ /classification/i

        return line.split[3].to_i if sat_score_in_line?(first, second)
      end
    end

    def sat_score_in_line?(first, second)
      first =~ /sat/i && second =~ /mathematics/i
    end

    def main_line(text)
      text.each_with_index do |line, index|
        first = line.split[0].strip
        return (index + 1) if first =~ /spring/i || first =~ /fall/i
      end
    end

    def parse_courses(file, courses)
      parsed = []

      file.each do |line|
        line = line.split("\t")
        next if line.length != 5

        parsed << [
          courses.find_by(subject: line[0].strip, course: line[1].strip.to_i),
          line[3].strip
        ]
      end
      parsed
    end

    def update_transcripts(parsed_transcripts)
      transcripts = user.transcripts
      parsed_transcripts.each do |transcript|
        next if transcript[1] == "w"

        create_or_update(transcript, user.taken_courses, transcripts)
      end
    end

    def create_or_update(transcript, taken_courses, transcripts)
      grade = transcript[1]
      c = Transcript.c?(grade)
      c_minus = Transcript.c_minus?(grade)

      if taken_courses.include? transcript[0]
        transcripts.find_by(course: transcript[0])
                   .update(grade_c_minus: c_minus, grade_c: c)
      else
        transcripts.create(course: transcript[0],
                           grade_c_minus: c_minus, grade_c: c)
      end
    end
  end
end
