
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]
  before_action :authorize_resource

  def index
    @orders = policy_scope(Order).order(created_at: :desc)
  end

  def show
  end

  def create
    @cart = current_user.cart

    if @cart
      @cart_items = @cart.cart_items

      if @cart_items.empty?
        redirect_to products_path, alert: "Your cart is empty. Add products to place order"
        return
      end

      @total_amount = @cart_items.sum do |item|
        item.price * item.qty
      end

      order_items_attributes = @cart_items.map do |item|
        {
          product_variant_id: item.product_variant_id,
          qty: item.qty,
          price: item.price
        }
      end

      @order = current_user.orders.create(
        total_amount: @total_amount,
        status: :pending,
        order_items_attributes: order_items_attributes
      )

      if @order.persisted?
        OrderMailer.with(order_id: @order.id).order_confirmation.deliver_now

        @cart.cart_items.destroy_all

        redirect_to @order, notice: "Order placed successfully!"
      else
        redirect_to products_path, alert: "Order could not be placed. please try again"
      end

    else
      redirect_to products_path, alert: "Cart does not exist."
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def authorization_resource
    if action_name == "show"
      @order
    else
      Order
    end
  end
end
