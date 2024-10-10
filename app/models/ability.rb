class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    if user.admin?
      can :manage, :all
    elsif user.worker?
      can :manage, User
      can :manage, Department
      can :manage, Ticket
    elsif user.customer?
      cannot :access, User
      cannot :access, Department
      can :manage, Ticket, requester_id: user.id
      can :manage, Ticket, creator_id: user.id
    end
  end
end
