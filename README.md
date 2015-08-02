# <img src="http://calu-advisor.herokuapp.com/assets/callogo2-f1a526e9046574f173668e58b1da422f.png" alt="CalU Advisor" width="75px" /> The California University of Pennsylvania Advisor
Currently at CalU there are two systems in place that help students build their schedule for the upcoming semester. The first of the systems is the Vulcan Information Portal(VIP), here students submit the classes they want to enroll in, the students prerequisites are validated, and all the courses that are being offered for the upcoming semester can be viewed. The second system is DegreeWorks which tells the student all the courses that are needed to fulfill their major and minor(s). 
<br><br>
These two systems should be communicating, but are not. Instead every student has to setup a meeting with their faculty advisor before every semester to go over what courses to enroll in for the next semester. In these meetings students and advisors have to go back and forth between these systems to develop a schedule which is time consuming and a hassle for everyone involved. 
<br><br>
The Calu Advisor combines these two systems. Before every semester a faculty advisor uploads all the courses that are going to be offered for the upcoming semester(.csv file) and the student uploads their current transcript from DegreeWorks. The CalU Advisor then gives the student only courses that:
<ul>
<li> are available;
<li> fulfill a requirement in their major or minor(s); and
<li> all prerequisites are met.
</ul>
The student can also filter courses by times they don't want class. After building their schedule they can email it to their advisor and without setting up a meeting their advisor can approve their schedule. 
<br><br>
The Calu Advisor is a responsive web application built on Rails 4 and Polymer 1.0 with a Postgres database. 
___
www.caluadvisor.com

