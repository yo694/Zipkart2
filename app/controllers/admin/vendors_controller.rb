class Admin::VendorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :authorize_resource
  
  def index
    vendors = Vendor.includes(:user).order(created_at: :desc)
    if params[:search].present?
      search = params[:search].strip
      search = "%#{Vendor.sanitize_sql_like(search)}%"
      vendors = vendors.where(
        "vendors.bussiness_name LIKE ? OR vendors.gst_id LIKE ?",
        search,
        search
        )
      end
      
      @pagy, @vendors = pagy(vendors, limit: 5)
    end

  private

  def authorization_resource
    [:admin, Vendor]
  end
end
