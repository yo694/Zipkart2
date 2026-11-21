class Admin::HomePolicy < ApplicationPolicy
  def index?
    user.is_a?(Admin)
  end
end