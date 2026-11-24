class Admin::UserPolicy < ApplicationPolicy
  def index?
    user.is_a?(Admin)
  end
end
