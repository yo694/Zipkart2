class OrderMailer < ApplicationMailer

  def order_confirmation
    @order = Order.find(params[:order_id])
    @user = @order.user

    mail(
      to: @user.email,
      subject: "Your Zipkart Order Confirmation"
    )
  end

end