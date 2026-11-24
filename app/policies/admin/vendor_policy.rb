class Admin::VendorPolicy < ApplicationPolicy
  def index?
    user.is_a?(Admin)
  end
end
