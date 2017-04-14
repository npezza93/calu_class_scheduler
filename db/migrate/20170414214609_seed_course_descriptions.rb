# frozen_string_literal: true

class SeedCourseDescriptions < ActiveRecord::Migration[5.1]
  def up
    return if Rails.env.test?

    subject_links.each do |link|
      seed_from_nodes(
        Nokogiri::HTML(open(link)).css("#main_content .subsection")
      )
    end
  end

  def down
  end

  private

  def subject_links
    url = "http://www.calu.edu/current-students/academic-resources/"\
          "catalogs/undergraduate/"

    @links ||= Nokogiri::HTML(open(url + "ug-course-desc.htm")).css(
      "#main_content"
    ).children.css("a").map { |node| url + node["href"] }
  end

  def seed_from_nodes(course_nodes)
    course_nodes.each do |course_section|
      course_name = course_section.css("h2").text.split("-").first.strip
      course =
        Course.find_by(subject: course_name[0..2], course: course_name[3..5])

      next unless course.present?

      set_description(course, course_section.css("content p").text)
    end
  end

  def set_description(course, text)
    description = text.split(/(\(\d* \w*.\))|(prereq)/i).first.strip

    course.update(description: description)
  end
end
