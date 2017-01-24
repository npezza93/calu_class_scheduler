# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.advisor?
      advisor_resources
    else
      student_resources
    end
  end

  def advisor_resources
    can :manage, User
    can :manage, Course
    can :manage, Major
    can :manage, CurriculumCategory
    can :manage, Offering
    can :manage, Semester
    can :update, ScheduleApproval
  end

  def student_resources
    can :manage, Schedule
    can :manage, Transcript
    can :manage, WorkSchedule
    can :set_session, Semester
    can :create, ScheduleApproval
  end
end
