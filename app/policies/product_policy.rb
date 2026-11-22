
class ProductPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.vendor.present?
  end

  def create?
    user.vendor.present?
  end

  def edit?
    user.vendor.present? && record.vendor_id == user.vendor.id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.vendor.present?
        scope.where(vendor_id: user.vendor.id)
      else
        scope.all
      end
    end
  end

end
