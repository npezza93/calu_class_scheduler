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
Course.where(subject: "CIS", course: 302).take.courses = [Course.where(subject: "CSC", course: 265).take]
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