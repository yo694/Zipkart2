class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize Order, :index?
    @orders = policy_scope(Order).order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])

    authorize @order
  end

  def create
    authorize Order, :create?

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

      @cart.cart_items.destroy_all

    else
      redirect_to products_path, alert: "Cart does not exist."
      return
    end

    redirect_to @order, notice: "Order placed successfully!"
  end
end