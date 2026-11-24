class AdminMailer < ApplicationMailer
  def vendor_registered
    @vendor = Vendor.find(params[:vendor_id])
    @user = @vendor.user

    mail(
      to: Admin.first.email,
      cc: @user.email,
      subject: "New Vendor Registration - Zipkart"
    )
  end
end