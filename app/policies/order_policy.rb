class OrderPolicy < ApplicationPolicy

  def index?
    user.is_a?(User)
  end

  def show?
    user.id == record.user_id
  end

  def create?
    user.is_a?(User)
  end


  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end