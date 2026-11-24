class Admin::VendorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_resource

  def index
    @vendors = Vendor.includes(:user).order(created_at: :desc)
  end

  private

  def authorization_resource
    [:admin, Vendor]
  end
end
