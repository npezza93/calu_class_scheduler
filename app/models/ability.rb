class Ability
  include CanCan::Ability

  def initialize(user)
    if user.advisor?
      can :manage, User
      can :manage, Course
      can :manage, Major
      can :manage, CurriculumCategory
      can :manage, Offering
      can :manage, Semester
    else
      can :manage, Schedule
      can :manage, Transcript
      can :manage, WorkSchedule
      can :set_session, Semester
    end
  end
end
