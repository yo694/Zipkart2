class OrderMailer < ApplicationMailer

  def order_confirmation
    @order = params[:order]
    @user = @order.user

    mail(
      to: @user.email,
      subject: "Your Zipkart Order Confirmation"
    )
  end

end