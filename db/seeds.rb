# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Course.create(subject: 'CSC', course: 101, title: 'Personal Productivity Software')
Course.create(subject: 'CSC', course: 120, title: 'Problem Solving and Programming Constructs')
Course.create(subject: 'CSC', course: 124, title: 'Computer Programming I')
Course.create(subject: 'CSC', course: 201, title: 'Internet Concepts')
Course.create(subject: 'CSC', course: 265, title: 'Object Oriented Programming')
Course.create(subject: 'CSC', course: 302, title: 'Visual Programming')
Course.create(subject: 'CSC', course: 323, title: 'Assembly Language Programming')
Course.create(subject: 'CSC', course: 328, title: 'Data Structures')
Course.create(subject: 'CSC', course: 400, title: 'Operating Systems')
Course.create(subject: 'CSC', course: 419, title: 'Internship')
Course.create(subject: 'CSC', course: 420, title: 'Artificial Intelligence')
Course.create(subject: 'CSC', course: 455, title: 'Structures of Programming Languages')
Course.create(subject: 'CSC', course: 460, title: 'Language Translation')
Course.create(subject: 'CSC', course: 492, title: 'Senior Project II')
Course.create(subject: 'CSC', course: 216, title: 'Logic and Switching Theory')
Course.create(subject: 'CSC', course: 304, title: 'COBOL')
Course.create(subject: 'CSC', course: 306, title: 'FORTRAN')
Course.create(subject: 'CET', course: 350, title: 'Technical Computing using Java')
Course.create(subject: 'CSC', course: 360, title: 'Analysis of Algorithms')
Course.create(subject: 'CSC', course: 378, title: 'Computer Architecture')
Course.create(subject: 'CSC', course: 424, title: 'Numerical Analysis')
Course.create(subject: 'CSC', course: 475, title: 'Theory of Languages')
Course.create(subject: 'CSC', course: 485, title: 'Special Topics in Computer Science')
Course.create(subject: 'CSC', course: 490, title: 'Senior Project I')
Course.create(subject: 'MAT', course: 195, title: 'Discrete Structures')
Course.create(subject: 'MAT', course: 282, title: 'Calculus II')
Course.create(subject: 'MAT', course: 341, title: 'Linear Algebra I')
Course.create(subject: 'MAT', course: 281, title: 'Calculus I')
Course.create(subject: 'ENG', course: 217, title: 'Scientific and Technical Writing I')
Course.create(subject: 'ENG', course: 101, title: 'English Composition I')

DaysTime.create(days: "MWF", start_time: "8:00", end_time: "8:50")
DaysTime.create(days: "MWF", start_time: "9:00", end_time: "9:50")
DaysTime.create(days: "MWF", start_time: "10:00", end_time: "10:50")
DaysTime.create(days: "MWF", start_time: "11:00", end_time: "11:50")
DaysTime.create(days: "MWF", start_time: "12:00", end_time: "12:50")
DaysTime.create(days: "MWF", start_time: "1:00", end_time: "1:50")
DaysTime.create(days: "MWF", start_time: "2:00", end_time: "2:50")
DaysTime.create(days: "MWF", start_time: "3:00", end_time: "3:50")
DaysTime.create(days: "MWF", start_time: "4:00", end_time: "4:50")
DaysTime.create(days: "MW", start_time: "4:00", end_time: "5:15")
DaysTime.create(days: "TR", start_time: "8:00", end_time: "9:15")
DaysTime.create(days: "TR", start_time: "9:30", end_time: "10:45")
DaysTime.create(days: "TR", start_time: "12:30", end_time: "1:45")
DaysTime.create(days: "TR", start_time: "2:00", end_time: "3:15")
DaysTime.create(days: "TR", start_time: "3:30", end_time: "4:45")
DaysTime.create(days: "M", start_time: "6:00", end_time: "8:45")
DaysTime.create(days: "W", start_time: "6:00", end_time: "8:45")
DaysTime.create(days: "W", start_time: "4:00", end_time: "6:50")

Course.where(subject: "CSC", course: 124).take.courses = [Course.where(subject: "CSC", course: 120).take]
Course.where(subject: "CSC", course: 216).take.courses = [Course.where(subject: "MAT", course: 195).take]
Course.where(subject: "CSC", course: 265).take.courses = [Course.where(subject: "CSC", course: 124).take]
Course.where(subject: "CSC", course: 323).take.courses = [Course.where(subject: "CSC", course: 328).take]
Course.where(subject: "CSC", course: 328).take.courses = [Course.where(subject: "CSC", course: 265).take]
Course.where(subject: "CET", course: 350).take.courses = [Course.where(subject: "CSC", course: 265).take]
Course.where(subject: "CSC", course: 360).take.courses = [Course.where(subject: "CSC", course: 328).take]
Course.where(subject: "CSC", course: 378).take.courses = [Course.where(subject: "CSC", course: 323).take]
Course.where(subject: "CSC", course: 400).take.courses = [Course.where(subject: "CSC", course: 378).take]
Course.where(subject: "CSC", course: 455).take.courses = [Course.where(subject: "CSC", course: 328).take]
Course.where(subject: "CSC", course: 460).take.courses = [Course.where(subject: "CSC", course: 475).take]
Course.where(subject: "CSC", course: 475).take.courses = [Course.where(subject: "CSC", course: 216).take, Course.where(subject: "CSC", course: 328).take]
Course.where(subject: "CSC", course: 490).take.courses = [Course.where(subject: "CSC", course: 265).take, Course.where(subject: "ENG", course: 217).take]
Course.where(subject: "CSC", course: 492).take.courses = [Course.where(subject: "CSC", course: 490).take]
Course.where(subject: "CSC", course: 302).take.courses = [Course.where(subject: "CSC", course: 265).take]
Course.where(subject: "CSC", course: 304).take.courses = [Course.where(subject: "CSC", course: 124).take]
Course.where(subject: "CSC", course: 306).take.courses = [Course.where(subject: "CSC", course: 120).take]
Course.where(subject: "CSC", course: 420).take.courses = [Course.where(subject: "CSC", course: 328).take]
Course.where(subject: "CSC", course: 424).take.courses = [Course.where(subject: "CSC", course: 328).take, Course.where(subject: "MAT", course: 282).take, Course.where(subject: "MAT", course: 341).take]
Course.where(subject: "MAT", course: 282).take.courses = [Course.where(subject: "MAT", course: 281).take]
Course.where(subject: "MAT", course: 341).take.courses = [Course.where(subject: "MAT", course: 195).take]
Course.where(subject: "ENG", course: 217).take.courses = [Course.where(subject: "ENG", course: 101).take]

Curriculum.create(course_id: Course.where(subject:"CSC", course: 120).take.id)
Curriculum.create(course_id: Course.where(subject:"ENG", course: 101).take.id)
Curriculum.create(course_id: Course.where(subject:"ENG", course: 217).take.id)
Curriculum.create(course_id: Course.where(subject:"MAT", course: 281).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 124).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 328).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 216).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 265).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 323).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 360).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 378).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 400).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 455).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 460).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 475).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 490).take.id)
Curriculum.create(course_id: Course.where(subject:"CSC", course: 492).take.id)
Curriculum.create(course_id: Course.where(subject:"CET", course: 350).take.id)
Curriculum.create(course_id: Course.where(subject:"MAT", course: 195).take.id)
Curriculum.create(course_id: Course.where(subject:"MAT", course: 282).take.id)
Curriculum.create(course_id: Course.where(subject:"MAT", course: 341).take.id)
