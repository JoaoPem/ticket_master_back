# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    if user.admin?
      can :manage, :all
    elsif user.worker?
      can :manage, :User
    elsif user.customer?
      cannot :access, User
    end
  end
end
