class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.role == "superadmin"
    can :manage, Document, user_id: user.id
  end

end
