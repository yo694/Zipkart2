class CartItemPolicy < ApplicationPolicy

  def create?
    user.id == record.cart.user_id
  end

end