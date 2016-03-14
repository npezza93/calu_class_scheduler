class Ability
  include CanCan::Ability

  def initialize(user)
    if user.advisor?
      can :manage, User
      can :manage, Course
      can :manage, Major
      can :manage, CurriculumCategory
    else
      can :manage, Schedule
      can :manage, Transcript
      can :manage, WorkSchedule
    end
  end
end
