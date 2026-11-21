class CartPolicy < ApplicationPolicy

  def show?
    user.id == record.user_id
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  def checkout?
    show?
  end

end