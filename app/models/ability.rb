# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.advisor?
      advisor_guest_resources(user)
    else
      student_resources
    end
  end

  def advisor_guest_resources(user)
    if user.guest?
      guest_resources
    else
      advisor_resources
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
    can :update, Semester
    can :create, ScheduleApproval
  end

  def guest_resources
    can :read, User
    can %i(read new edit), Course
    can %i(read new edit), Major
    can %i(read new edit), CurriculumCategory
    can %i(read new edit), Offering
    can :update, Semester
  end
end
