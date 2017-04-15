# frozen_string_literal: true

class InitializeRangesForSemesters < ActiveRecord::Migration[5.1]
  def up
    update_existing("Fall 2014", 2014, :fall)
    update_existing("Spring 2015", 2015, :spring)
    update_existing("Fall 2015", 2015, :fall)
    update_existing("Spring 2016", 2016, :spring)
    update_existing("Fall 2016", 2016, :fall)
    update_existing("Spring 2017", 2017, :spring)

    add_extra_semesters
  end

  def down
  end

  private

  def update_existing(semester, year, type)
    semester = Semester.find_by(semester: semester)
    if type == :fall
      start_on = Date.new(year, 6)
      end_on   = start_on.end_of_year
    else
      start_on = Date.new(year, 6).beginning_of_year
      end_on   = Date.new(year, 6) - 1.second
    end

    semester.update(start_on: start_on, end_on: end_on)
  end

  def add_extra_semesters
    create_semester("Fall 2017", 2017, :fall)

    (2018..2025).to_a.each do |year|
      create_semester("Spring #{year}", year, :spring)
      create_semester("Fall #{year}", year, :fall)
    end
  end

  def create_semester(name, year, type)
    if type == :fall
      start_on = Date.new(year, 6)
      end_on   = start_on.end_of_year
    else
      start_on = Date.new(year, 6).beginning_of_year
      end_on   = Date.new(year, 6) - 1.second
    end

    Semester.create(semester: name, start_on: start_on, end_on: end_on)
  end
end
