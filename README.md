# ![CalU Advisor](https://raw.githubusercontent.com/npezza93/calu_class_scheduler/master/app/assets/images/callogo75.png) The California University of Pennsylvania Advisor

[![Build Status](https://travis-ci.org/npezza93/calu_class_scheduler.svg)](https://travis-ci.org/npezza93/calu_class_scheduler)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/npezza93/calu_class_scheduler/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/npezza93/calu_class_scheduler/?branch=master)
[![Code Climate](https://codeclimate.com/github/npezza93/calu_class_scheduler/badges/gpa.svg)](https://codeclimate.com/github/npezza93/calu_class_scheduler)
[![Test Coverage](https://codeclimate.com/github/npezza93/calu_class_scheduler/badges/coverage.svg)](https://codeclimate.com/github/npezza93/calu_class_scheduler/coverage)
[![Issue Count](https://codeclimate.com/github/npezza93/calu_class_scheduler/badges/issue_count.svg)](https://codeclimate.com/github/npezza93/calu_class_scheduler)

Currently at CalU there are two systems in place that help students build their schedule for the upcoming semester. The first of the systems is the Vulcan Information Portal(VIP), here students submit the classes they want to enroll in, the students prerequisites are validated, and all the courses that are being offered for the upcoming semester can be viewed. The second system is DegreeWorks which tells the student all the courses that are needed to fulfill their major and minor(s).

These two systems should be communicating, but are not. Instead every student has to setup a meeting with their faculty advisor before every semester to go over what courses to enroll in for the next semester. In these meetings students and advisors have to go back and forth between these systems to develop a schedule which is time consuming and a hassle for everyone involved.

The Calu Advisor combines these two systems. Before every semester a faculty advisor uploads all the courses that are going to be offered for the upcoming semester(CSV file) and the student uploads their current transcript from DegreeWorks. The CalU Advisor then gives the student only courses that:

-   are available;
-   fulfill a requirement in their major or minor(s); and
-   all prerequisites are met.

The student can also filter courses by times they don't want class. After building their schedule they can email it to their advisor and without setting up a meeting their advisor can approve their schedule.


The Calu Advisor is a responsive web application built on Rails 5.0.1, [Material Design Lite](https://getmdl.io/), and [Materialize](http://materializecss.com/) with a PostgreSQL database.
___
[www.caluadvisor.com](www.caluadvisor.com)
