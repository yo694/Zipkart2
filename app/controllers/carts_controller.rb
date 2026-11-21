class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :checkout]

  def show
    authorize @cart

    @cart_items = @cart.cart_items.includes(product_variant: :product)
  end

  def edit
    authorize @cart
  end

  def update
    authorize @cart

    if @cart.update(cart_params)
      redirect_to @cart, notice: "Cart updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @cart

    @cart.destroy
    redirect_to products_path, notice: "Cart deleted successfully"
  end

  def checkout
    authorize @cart, :checkout?

    @cart_items = @cart.cart_items.includes(product_variant: :product)
    @total_amount = @cart_items.sum { |item| item.price * item.qty }
  end

  private

  def set_cart
    @cart = current_user.cart
    redirect_to products_path, alert: "Cart not found" unless @cart
  end

  def cart_params
    params.require(:cart).permit(
      cart_items_attributes: [
        :id,
        :qty,
        :_destroy
      ]
    )
  end
end