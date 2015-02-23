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
Course.create(subject: 'CSC', course: 455, title: 'Structures of Programming Languages')
Course.create(subject: 'CSC', course: 460, title: 'Language Translation')
Course.create(subject: 'CSC', course: 492, title: 'Senior Project II')
Course.create(subject: 'CSC', course: 216, title: 'Logic and Switching Theory')
Course.create(subject: 'CSC', course: 304, title: 'COBOL')
Course.create(subject: 'CSC', course: 306, title: 'FORTRAN')
Course.create(subject: 'CET', course: 350, title: 'Technical Computing using Java')
Course.create(subject: 'CSC', course: 360, title: 'Analysis of Algorithms')
Course.create(subject: 'CSC', course: 378, title: 'Computer Architecture')
Course.create(subject: 'CSC', course: 475, title: 'Theory of Languages')
Course.create(subject: 'CSC', course: 490, title: 'Senior Project I')
Course.create(subject: 'MAT', course: 195, title: 'Discrete Structures')
Course.create(subject: 'MAT', course: 282, title: 'Calculus II')
Course.create(subject: 'MAT', course: 341, title: 'Linear Algebra I')
Course.create(subject: 'MAT', course: 281, title: 'Calculus I')
Course.create(subject: 'MAT', course: 215, title: 'Statistics')
Course.create(subject: 'ENG', course: 217, title: 'Scientific and Technical Writing I')
Course.create(subject: 'ENG', course: 101, title: 'English Composition I')
Course.create(subject: 'CIS', course: 321, title: 'Data Base Management Systems and DB Design')
Course.create(subject: 'CSC', course: 420, title: 'Artificial Intelligence')
Course.create(subject: 'CSC', course: 424, title: 'Numerical Analysis')
Course.create(subject: 'CSC', course: 485, title: 'Special Topics in Computer Science')
Course.create(subject: 'CET', course: 440, title: 'Computer Networking', credits: 4)
Course.create(subject: 'UNI', course: 100, title: 'First Year Seminar', credits: 1)
Course.create(subject: 'HON', course: 100, title: 'Honors & University Orientation', credits: 1)
Course.create(subject: 'CIS', course: 352, title: 'Global, Economic and Social Ethical Issues in Computing')
Course.create(subject: 'MAT', course: 381, title: 'Calculus III')
Course.create(subject: 'MAT', course: 441, title: 'Linear Algebra II')
Course.create(subject: 'COM', course: 101, title: 'Oral Communication')
Course.create(subject: 'MAT', course: 382, title: 'Calculus IV')
Course.create(subject: 'COM', course: 230, title: 'Argument/Debate')
Course.create(subject: 'COM', course: 250, title: 'Oral Com Management')
Course.create(subject: 'MAT', course: 181, title: 'College Algebra')

Course.create(subject: 'ATE', course: 340, title: 'Sports Nutrition')
Course.create(subject: 'BIO', course: 112, title: 'Bio Sex Tr Dis')
Course.create(subject: 'DAN', course: 233, title: 'Jazz Tech II')
Course.create(subject: 'DAN', course: 260, title: 'Modern Dance')
Course.create(subject: 'HSC', course: 115, title: 'Cur Iss Health')
Course.create(subject: 'HSC', course: 250, title: 'Hth/Phy Ed Meth')
Course.create(subject: 'HSC', course: 315, title: 'Fst Aid/Per Safe')
Course.create(subject: 'NUR', course: 101, title: 'Women Health')
Course.create(subject: 'PSY', course: 222, title: 'Psy Stress Mgt')
Course.create(subject: 'REC', course: 165, title: 'Intro Rec Leis')
Course.create(subject: 'SOW', course: 222, title: 'Human Sex/Soc')


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
Course.where(subject: "CET", course: 440).take.courses = [Course.where(subject: "CSC", course: 124).take]
Course.where(subject: "MAT", course: 381).take.courses = [Course.where(subject: "MAT", course: 282).take]
Course.where(subject: "MAT", course: 441).take.courses = [Course.where(subject: "MAT", course: 341).take]
Course.where(subject: 'MAT', course: 382).take.courses = [Course.where(subject: "MAT", course: 381).take]

DaysTime.create(days: "MWF", start_time: "8:00 am", end_time: "8:50 am")
DaysTime.create(days: "MWF", start_time: "9:00 am", end_time: "9:50 am")
DaysTime.create(days: "MWF", start_time: "10:00 am", end_time: "10:50 am")
DaysTime.create(days: "MWF", start_time: "11:00 am", end_time: "11:50 am")
DaysTime.create(days: "MWF", start_time: "12:00 pm", end_time: "12:50 pm")
DaysTime.create(days: "MWF", start_time: "1:00 pm", end_time: "1:50 pm")
DaysTime.create(days: "MWF", start_time: "2:00 pm", end_time: "2:50 pm")
DaysTime.create(days: "MWF", start_time: "3:00 pm", end_time: "3:50 pm")
DaysTime.create(days: "MWF", start_time: "4:00 pm", end_time: "4:50 pm")
DaysTime.create(days: "MW", start_time: "4:00 pm", end_time: "5:15 pm")
DaysTime.create(days: "TR", start_time: "8:00 am", end_time: "9:15 am")
DaysTime.create(days: "TR", start_time: "9:30 am", end_time: "10:45 am")
DaysTime.create(days: "TR", start_time: "12:30 pm", end_time: "1:45 pm")
DaysTime.create(days: "TR", start_time: "2:00 pm", end_time: "3:15 pm")
DaysTime.create(days: "TR", start_time: "3:30 pm", end_time: "4:45 pm")
DaysTime.create(days: "M", start_time: "6:00 pm", end_time: "8:45 pm")
DaysTime.create(days: "W", start_time: "6:00 pm", end_time: "8:45 pm")
DaysTime.create(days: "W", start_time: "4:00 pm", end_time: "6:50 pm")

WorkDaysTime.create(days: "M", start_time: "8:00am", end_time: "8:30am")
WorkDaysTime.create(days: "M", start_time: "8:30am", end_time: "9:00am")
WorkDaysTime.create(days: "M", start_time: "9:00am", end_time: "9:30am")
WorkDaysTime.create(days: "M", start_time: "9:30am", end_time: "10:00am")
WorkDaysTime.create(days: "M", start_time: "10:00am", end_time: "10:30am")
WorkDaysTime.create(days: "M", start_time: "10:30am", end_time: "11:00am")
WorkDaysTime.create(days: "M", start_time: "11:00am", end_time: "11:30am")
WorkDaysTime.create(days: "M", start_time: "11:30am", end_time: "12:00pm")
WorkDaysTime.create(days: "M", start_time: "12:00pm", end_time: "12:30pm")
WorkDaysTime.create(days: "M", start_time: "12:30pm", end_time: "1:00pm")
WorkDaysTime.create(days: "M", start_time: "1:00pm", end_time: "1:30pm")
WorkDaysTime.create(days: "M", start_time: "1:30pm", end_time: "2:00pm")
WorkDaysTime.create(days: "M", start_time: "2:00pm", end_time: "2:30pm")
WorkDaysTime.create(days: "M", start_time: "2:30pm", end_time: "3:00pm")
WorkDaysTime.create(days: "M", start_time: "3:00pm", end_time: "3:30pm")
WorkDaysTime.create(days: "M", start_time: "3:30pm", end_time: "4:00pm")
WorkDaysTime.create(days: "M", start_time: "4:00pm", end_time: "4:30pm")
WorkDaysTime.create(days: "M", start_time: "4:30pm", end_time: "5:00pm")
WorkDaysTime.create(days: "M", start_time: "5:00pm", end_time: "5:30pm")
WorkDaysTime.create(days: "M", start_time: "5:30pm", end_time: "6:00pm")
WorkDaysTime.create(days: "M", start_time: "6:00pm", end_time: "6:30pm")
WorkDaysTime.create(days: "M", start_time: "6:30pm", end_time: "7:00pm")
WorkDaysTime.create(days: "M", start_time: "7:00pm", end_time: "7:30pm")
WorkDaysTime.create(days: "M", start_time: "7:30pm", end_time: "8:00pm")
WorkDaysTime.create(days: "M", start_time: "8:00pm", end_time: "8:30pm")
WorkDaysTime.create(days: "M", start_time: "8:30pm", end_time: "9:00pm")
WorkDaysTime.create(days: "M", start_time: "9:00pm", end_time: "9:30pm")
WorkDaysTime.create(days: "M", start_time: "9:30pm", end_time: "10:00pm")
WorkDaysTime.create(days: "T", start_time: "8:00am", end_time: "8:30am")
WorkDaysTime.create(days: "T", start_time: "8:30am", end_time: "9:00am")
WorkDaysTime.create(days: "T", start_time: "9:00am", end_time: "9:30am")
WorkDaysTime.create(days: "T", start_time: "9:30am", end_time: "10:00am")
WorkDaysTime.create(days: "T", start_time: "10:00am", end_time: "10:30am")
WorkDaysTime.create(days: "T", start_time: "10:30am", end_time: "11:00am")
WorkDaysTime.create(days: "T", start_time: "11:00am", end_time: "11:30am")
WorkDaysTime.create(days: "T", start_time: "11:30am", end_time: "12:00pm")
WorkDaysTime.create(days: "T", start_time: "12:00pm", end_time: "12:30pm")
WorkDaysTime.create(days: "T", start_time: "12:30pm", end_time: "1:00pm")
WorkDaysTime.create(days: "T", start_time: "1:00pm", end_time: "1:30pm")
WorkDaysTime.create(days: "T", start_time: "1:30pm", end_time: "2:00pm")
WorkDaysTime.create(days: "T", start_time: "2:00pm", end_time: "2:30pm")
WorkDaysTime.create(days: "T", start_time: "2:30pm", end_time: "3:00pm")
WorkDaysTime.create(days: "T", start_time: "3:00pm", end_time: "3:30pm")
WorkDaysTime.create(days: "T", start_time: "3:30pm", end_time: "4:00pm")
WorkDaysTime.create(days: "T", start_time: "4:00pm", end_time: "4:30pm")
WorkDaysTime.create(days: "T", start_time: "4:30pm", end_time: "5:00pm")
WorkDaysTime.create(days: "T", start_time: "5:00pm", end_time: "5:30pm")
WorkDaysTime.create(days: "T", start_time: "5:30pm", end_time: "6:00pm")
WorkDaysTime.create(days: "T", start_time: "6:00pm", end_time: "6:30pm")
WorkDaysTime.create(days: "T", start_time: "6:30pm", end_time: "7:00pm")
WorkDaysTime.create(days: "T", start_time: "7:00pm", end_time: "7:30pm")
WorkDaysTime.create(days: "T", start_time: "7:30pm", end_time: "8:00pm")
WorkDaysTime.create(days: "T", start_time: "8:00pm", end_time: "8:30pm")
WorkDaysTime.create(days: "T", start_time: "8:30pm", end_time: "9:00pm")
WorkDaysTime.create(days: "T", start_time: "9:00pm", end_time: "9:30pm")
WorkDaysTime.create(days: "T", start_time: "9:30pm", end_time: "10:00pm")
WorkDaysTime.create(days: "W", start_time: "8:00am", end_time: "8:30am")
WorkDaysTime.create(days: "W", start_time: "8:30am", end_time: "9:00am")
WorkDaysTime.create(days: "W", start_time: "9:00am", end_time: "9:30am")
WorkDaysTime.create(days: "W", start_time: "9:30am", end_time: "10:00am")
WorkDaysTime.create(days: "W", start_time: "10:00am", end_time: "10:30am")
WorkDaysTime.create(days: "W", start_time: "10:30am", end_time: "11:00am")
WorkDaysTime.create(days: "W", start_time: "11:00am", end_time: "11:30am")
WorkDaysTime.create(days: "W", start_time: "11:30am", end_time: "12:00pm")
WorkDaysTime.create(days: "W", start_time: "12:00pm", end_time: "12:30pm")
WorkDaysTime.create(days: "W", start_time: "12:30pm", end_time: "1:00pm")
WorkDaysTime.create(days: "W", start_time: "1:00pm", end_time: "1:30pm")
WorkDaysTime.create(days: "W", start_time: "1:30pm", end_time: "2:00pm")
WorkDaysTime.create(days: "W", start_time: "2:00pm", end_time: "2:30pm")
WorkDaysTime.create(days: "W", start_time: "2:30pm", end_time: "3:00pm")
WorkDaysTime.create(days: "W", start_time: "3:00pm", end_time: "3:30pm")
WorkDaysTime.create(days: "W", start_time: "3:30pm", end_time: "4:00pm")
WorkDaysTime.create(days: "W", start_time: "4:00pm", end_time: "4:30pm")
WorkDaysTime.create(days: "W", start_time: "4:30pm", end_time: "5:00pm")
WorkDaysTime.create(days: "W", start_time: "5:00pm", end_time: "5:30pm")
WorkDaysTime.create(days: "W", start_time: "5:30pm", end_time: "6:00pm")
WorkDaysTime.create(days: "W", start_time: "6:00pm", end_time: "6:30pm")
WorkDaysTime.create(days: "W", start_time: "6:30pm", end_time: "7:00pm")
WorkDaysTime.create(days: "W", start_time: "7:00pm", end_time: "7:30pm")
WorkDaysTime.create(days: "W", start_time: "7:30pm", end_time: "8:00pm")
WorkDaysTime.create(days: "W", start_time: "8:00pm", end_time: "8:30pm")
WorkDaysTime.create(days: "W", start_time: "8:30pm", end_time: "9:00pm")
WorkDaysTime.create(days: "W", start_time: "9:00pm", end_time: "9:30pm")
WorkDaysTime.create(days: "W", start_time: "9:30pm", end_time: "10:00pm")
WorkDaysTime.create(days: "R", start_time: "8:00am", end_time: "8:30am")
WorkDaysTime.create(days: "R", start_time: "8:30am", end_time: "9:00am")
WorkDaysTime.create(days: "R", start_time: "9:00am", end_time: "9:30am")
WorkDaysTime.create(days: "R", start_time: "9:30am", end_time: "10:00am")
WorkDaysTime.create(days: "R", start_time: "10:00am", end_time: "10:30am")
WorkDaysTime.create(days: "R", start_time: "10:30am", end_time: "11:00am")
WorkDaysTime.create(days: "R", start_time: "11:00am", end_time: "11:30am")
WorkDaysTime.create(days: "R", start_time: "11:30am", end_time: "12:00pm")
WorkDaysTime.create(days: "R", start_time: "12:00pm", end_time: "12:30pm")
WorkDaysTime.create(days: "R", start_time: "12:30pm", end_time: "1:00pm")
WorkDaysTime.create(days: "R", start_time: "1:00pm", end_time: "1:30pm")
WorkDaysTime.create(days: "R", start_time: "1:30pm", end_time: "2:00pm")
WorkDaysTime.create(days: "R", start_time: "2:00pm", end_time: "2:30pm")
WorkDaysTime.create(days: "R", start_time: "2:30pm", end_time: "3:00pm")
WorkDaysTime.create(days: "R", start_time: "3:00pm", end_time: "3:30pm")
WorkDaysTime.create(days: "R", start_time: "3:30pm", end_time: "4:00pm")
WorkDaysTime.create(days: "R", start_time: "4:00pm", end_time: "4:30pm")
WorkDaysTime.create(days: "R", start_time: "4:30pm", end_time: "5:00pm")
WorkDaysTime.create(days: "R", start_time: "5:00pm", end_time: "5:30pm")
WorkDaysTime.create(days: "R", start_time: "5:30pm", end_time: "6:00pm")
WorkDaysTime.create(days: "R", start_time: "6:00pm", end_time: "6:30pm")
WorkDaysTime.create(days: "R", start_time: "6:30pm", end_time: "7:00pm")
WorkDaysTime.create(days: "R", start_time: "7:00pm", end_time: "7:30pm")
WorkDaysTime.create(days: "R", start_time: "7:30pm", end_time: "8:00pm")
WorkDaysTime.create(days: "R", start_time: "8:00pm", end_time: "8:30pm")
WorkDaysTime.create(days: "R", start_time: "8:30pm", end_time: "9:00pm")
WorkDaysTime.create(days: "R", start_time: "9:00pm", end_time: "9:30pm")
WorkDaysTime.create(days: "R", start_time: "9:30pm", end_time: "10:00pm")
WorkDaysTime.create(days: "F", start_time: "8:00am", end_time: "8:30am")
WorkDaysTime.create(days: "F", start_time: "8:30am", end_time: "9:00am")
WorkDaysTime.create(days: "F", start_time: "9:00am", end_time: "9:30am")
WorkDaysTime.create(days: "F", start_time: "9:30am", end_time: "10:00am")
WorkDaysTime.create(days: "F", start_time: "10:00am", end_time: "10:30am")
WorkDaysTime.create(days: "F", start_time: "10:30am", end_time: "11:00am")
WorkDaysTime.create(days: "F", start_time: "11:00am", end_time: "11:30am")
WorkDaysTime.create(days: "F", start_time: "11:30am", end_time: "12:00pm")
WorkDaysTime.create(days: "F", start_time: "12:00pm", end_time: "12:30pm")
WorkDaysTime.create(days: "F", start_time: "12:30pm", end_time: "1:00pm")
WorkDaysTime.create(days: "F", start_time: "1:00pm", end_time: "1:30pm")
WorkDaysTime.create(days: "F", start_time: "1:30pm", end_time: "2:00pm")
WorkDaysTime.create(days: "F", start_time: "2:00pm", end_time: "2:30pm")
WorkDaysTime.create(days: "F", start_time: "2:30pm", end_time: "3:00pm")
WorkDaysTime.create(days: "F", start_time: "3:00pm", end_time: "3:30pm")
WorkDaysTime.create(days: "F", start_time: "3:30pm", end_time: "4:00pm")
WorkDaysTime.create(days: "F", start_time: "4:00pm", end_time: "4:30pm")
WorkDaysTime.create(days: "F", start_time: "4:30pm", end_time: "5:00pm")
WorkDaysTime.create(days: "F", start_time: "5:00pm", end_time: "5:30pm")
WorkDaysTime.create(days: "F", start_time: "5:30pm", end_time: "6:00pm")
WorkDaysTime.create(days: "F", start_time: "6:00pm", end_time: "6:30pm")
WorkDaysTime.create(days: "F", start_time: "6:30pm", end_time: "7:00pm")
WorkDaysTime.create(days: "F", start_time: "7:00pm", end_time: "7:30pm")
WorkDaysTime.create(days: "F", start_time: "7:30pm", end_time: "8:00pm")
WorkDaysTime.create(days: "F", start_time: "8:00pm", end_time: "8:30pm")
WorkDaysTime.create(days: "F", start_time: "8:30pm", end_time: "9:00pm")
WorkDaysTime.create(days: "F", start_time: "9:00pm", end_time: "9:30pm")
WorkDaysTime.create(days: "F", start_time: "9:30pm", end_time: "10:00pm")

Semester.create(semester: "Fall 2014")
Semester.create(semester: "Spring 2015", active: true)
Semester.create(semester: "Fall 2015")
Semester.create(semester: "Spring 2016")
Semester.create(semester: "Fall 2016")
Semester.create(semester: "Spring 2017")

Major.create(major: "Computer Science")
Major.create(major: "Mathematics")
Major.create(major: "Computer Engineering Technology")
Major.create(major: "Chemistry")

CurriculumCategory.create!([
  {category: "Core", required_amount_of_credits: 36, major_id: 1, minor: false},
  {category: "Values", required_amount_of_credits: 3, major_id: 1, minor: false},
  {category: "Elective1", required_amount_of_credits: 6, major_id: 1, minor: false},
  {category: "Elective2", required_amount_of_credits: 6, major_id: 1, minor: false},
  {category: "Critical Thinking Skills", required_amount_of_credits: 3, major_id: 1, minor: false},
  {category: "Technological Literacy", required_amount_of_credits: 6, major_id: 1, minor: false},
  {category: "Building a Sense of Community", required_amount_of_credits: 1, major_id: 1, minor: false},
  {category: "Communication Skills", required_amount_of_credits: 9, major_id: 1, minor: false},
  {category: "Mathematics", required_amount_of_credits: 18, major_id: 1, minor: false},
  {category: "Required", required_amount_of_credits: 15, major_id: 1, minor: true},
  {category: "Electives", required_amount_of_credits: 6, major_id: 1, minor: true},
  {category: "Required", required_amount_of_credits: 15, major_id: 2, minor: true},
  {category: "Electives", required_amount_of_credits: 6, major_id: 2, minor: true}
])

CurriculumCategoryCourse.create!([
  {curriculum_category_id: 1, course_id: 5},
  {curriculum_category_id: 1, course_id: 7},
  {curriculum_category_id: 1, course_id: 9},
  {curriculum_category_id: 1, course_id: 11},
  {curriculum_category_id: 1, course_id: 12},
  {curriculum_category_id: 1, course_id: 13},
  {curriculum_category_id: 1, course_id: 21},
  {curriculum_category_id: 1, course_id: 17},
  {curriculum_category_id: 1, course_id: 18},
  {curriculum_category_id: 1, course_id: 19},
  {curriculum_category_id: 1, course_id: 20},
  {curriculum_category_id: 1, course_id: 14},
  {curriculum_category_id: 2, course_id: 36},
  {curriculum_category_id: 3, course_id: 29},
  {curriculum_category_id: 3, course_id: 30},
  {curriculum_category_id: 3, course_id: 31},
  {curriculum_category_id: 3, course_id: 32},
  {curriculum_category_id: 3, course_id: 33},
  {curriculum_category_id: 4, course_id: 6},
  {curriculum_category_id: 4, course_id: 15},
  {curriculum_category_id: 4, course_id: 16},
  {curriculum_category_id: 4, course_id: 10},
  {curriculum_category_id: 5, course_id: 2},
  {curriculum_category_id: 6, course_id: 3},
  {curriculum_category_id: 6, course_id: 8},
  {curriculum_category_id: 7, course_id: 34},
  {curriculum_category_id: 7, course_id: 35},
  {curriculum_category_id: 8, course_id: 28},
  {curriculum_category_id: 8, course_id: 39},
  {curriculum_category_id: 8, course_id: 27},
  {curriculum_category_id: 9, course_id: 22},
  {curriculum_category_id: 9, course_id: 25},
  {curriculum_category_id: 9, course_id: 23},
  {curriculum_category_id: 9, course_id: 24},
  {curriculum_category_id: 9, course_id: 26},
  {curriculum_category_id: 9, course_id: 37},
  {curriculum_category_id: 9, course_id: 38},
  {curriculum_category_id: 10, course_id: 2},
  {curriculum_category_id: 10, course_id: 3},
  {curriculum_category_id: 10, course_id: 14},
  {curriculum_category_id: 10, course_id: 5},
  {curriculum_category_id: 10, course_id: 22},
  {curriculum_category_id: 11, course_id: 6},
  {curriculum_category_id: 11, course_id: 15},
  {curriculum_category_id: 11, course_id: 16},
  {curriculum_category_id: 11, course_id: 8},
  {curriculum_category_id: 11, course_id: 10},
  {curriculum_category_id: 12, course_id: 25},
  {curriculum_category_id: 12, course_id: 23},
  {curriculum_category_id: 12, course_id: 24},
  {curriculum_category_id: 12, course_id: 37},
  {curriculum_category_id: 13, course_id: 40}
])

User.create(first_name: "Anthony", last_name: "Pyzdrowski", email: "pyzdrowski@calu.edu", advisor: true, password: 'password', password_confirmation: 'password', major_id: 1)
User.create(first_name: "Weifeng", last_name: "Chen", email: "chen@calu.edu", advisor: true, password: 'password', password_confirmation: 'password', major_id: 1)
User.create(first_name: "Paul", last_name: "Sible", email: "sible@calu.edu", advisor: true, password: 'password', password_confirmation: 'password', major_id: 1)
User.create(first_name: "Jeffrey", last_name: "Sumey", email: "sumey@calu.edu", advisor: true, password: 'password', password_confirmation: 'password', major_id: 3)
User.create(first_name: "Ghassan", last_name: "Salim", email: "salim@calu.edu", advisor: true, password: 'password', password_confirmation: 'password', major_id: 3)
User.create(first_name: "Gary", last_name: "DeLorenzo", email: "delorenzo@calu.edu", advisor: true, password: "password", password_confirmation: "password", major_id: 3)
