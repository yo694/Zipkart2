class Admin::VendorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_resource

  def index
    @pagy,@vendors = pagy(Vendor.includes(:user).order(created_at: :desc),limit: 5)
  end

  private

  def authorization_resource
    [:admin, Vendor]
  end
end
