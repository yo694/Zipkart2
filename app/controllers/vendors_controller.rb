
class VendorsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_existing_vendor, only: [:new, :create]
  before_action :authorize_resource
  before_action :prepare_vendor, only: [:new, :create]

  def home
  end

  def new
  end

  def create
    if @vendor.save
      AdminMailer.with(vendor_id: @vendor.id).vendor_registered.deliver_now
      redirect_to vendor_path, notice: "Vendor Registered Successfully!!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prepare_vendor
    if action_name == "create"
      @vendor = current_user.build_vendor(vendor_params)
    else
      @vendor = current_user.build_vendor
    end
  end

  def authorization_resource
    Vendor
  end

  def vendor_params
    params.require(:vendor).permit(
      :bussiness_name,
      :bussiness_description,
      :gst_id
    )
  end

  def check_existing_vendor
    if current_user.vendor.present?
      redirect_to vendor_path, alert: "You are already registered as a vendor"
    end
  end
end
