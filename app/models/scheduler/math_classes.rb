module Scheduler::MathClasses
  def math_class?(course)
    course == mat_181 ||
      course == mat_191 ||
      course == mat_199 ||
      course == mat_281
  end
end
