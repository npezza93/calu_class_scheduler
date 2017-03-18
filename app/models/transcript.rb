# frozen_string_literal: true
# == Schema Information
#
# Table name: transcripts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  course_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#  grade_c_minus :boolean
#  grade_c       :boolean
#

class Transcript < ApplicationRecord
  GRADES = %w(A A- B+ B B- C+ C C- D+ D D- F).freeze

  belongs_to :user
  belongs_to :course

  validates :course, uniqueness: {
    scope: :user, message: "You've already taken this course!"
  }, presence: { message: "A course must be selected!" }

  # methods for importing transcript text
  class << self
    def import(text, user)
      text = text.split(/[\r\n]+/)
      text.reject!(&:empty?)

      return nil if text.blank? ||
                    text[0].casecmp("DegreeWorks: New Production") == -1
      update_sat_scores(text, user)
      parsed_transcripts = parse_courses(text.drop(main_line(text)), Course.all)

      update_transcripts(user, parsed_transcripts)
    end

    def update_sat_scores(text, user)
      math_sat_score = sat_info(text, user)

      user.update(
        sat_520: math_sat_score >= 520,
        sat_580: math_sat_score >= 580,
        sat_440: math_sat_score >= 440,
        sat_640: math_sat_score >= 640,
        sat_700: math_sat_score >= 700
      )
    end

    def sat_info(text, user)
      text.each do |line|
        first = line.split[0].strip
        second = line.split[1]
        next if first.nil?

        user.update(class_standing: second) if first =~ /classification/i

        return line.split[3].to_i if first =~ /sat/i && second =~ /mathematics/i
      end
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

    def update_transcripts(user, parsed_transcripts)
      transcripts = user.transcripts
      parsed_transcripts.each do |transcript|
        next if transcript[1] == "w"

        create_or_update(transcript, user.taken_courses, transcripts)
      end
    end

    def create_or_update(transcript, taken_courses, transcripts)
      grade = transcript[1]
      c = c?(grade)
      c_minus = c_minus?(grade)

      if taken_courses.include? transcript[0]
        transcripts.find_by(course: transcript[0])
                   .update(grade_c_minus: c_minus, grade_c: c)
      else
        transcripts.create(course: transcript[0],
                           grade_c_minus: c_minus, grade_c: c)
      end
    end

    def not_an_actual_letter_grade?(grade)
      (grade[0].casecmp("t") || grade.downcase.include?("reg") ||
         grade.downcase.include?("p")) > -1
    end

    def letter_grade_check(grade, index)
      not_an_actual_letter_grade?(grade) ||
        (GRADES.index(grade) && GRADES.index(grade) <= index)
    end

    def c?(grade)
      return true if letter_grade_check(grade, 6)

      false
    end

    def c_minus?(grade)
      return true if letter_grade_check(grade, 7)

      false
    end
  end
end
