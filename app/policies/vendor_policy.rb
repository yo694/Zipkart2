class VendorPolicy < ApplicationPolicy

  def home?
    user.vendor.present?
  end

  def new?
    user.vendor.nil?
  end

  def create?
    user.vendor.nil?
  end

end