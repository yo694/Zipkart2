class VendorPolicy < ApplicationPolicy

  def home?
    user.present? && user.vendor.present?
  end

  def new?
    user.present? && user.vendor.nil?
  end

  def create?
    user.present? && user.vendor.nil?
  end

end