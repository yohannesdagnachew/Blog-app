class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is? :admin
      can :manage, :all
    else
      can :read, :all
      can :create, Post
      can :create, Comment
      can :create, Like
      can :manage, Post, author: user
      can :manage, Comment, author: user
    end
  end
end
