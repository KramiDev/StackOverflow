class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :create, Vote do |vote|
      vote.voteable.user_id != user.id
    end
    can :destroy, Vote do |vote|
      vote.voteable.user_id != user.id
    end
    can :update, [Question, Answer, Comment], user: user
    can :destroy, [Question, Answer, Comment, Vote], user: user
    can :destroy, Attachment do |attachment|
      attachment.attachable.user_id == user.id
    end
    can :me, User, id: user.id
    can :best, Answer do |answer|
      answer.question.user_id == user.id && answer.user_id != user.id
    end
  end
end
