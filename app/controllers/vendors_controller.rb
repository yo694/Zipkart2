class VendorsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_existing_vendor, only: [:new, :create]

  def home 
  end

  def new 
    @vendor = current_user.build_vendor
  end

  def create
    @vendor = current_user.build_vendor(vendor_params)

    if @vendor.save
      redirect_to vendor_path , notice: "Vendor Registered Successfully!!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:bussiness_name,:bussiness_desription,:gst_id)
  end

  def check_existing_vendor
    if current_user.vendor.present?
      redirect_to vendor_path , alert: "You are already registered as a vendor"
    end
  end
end
