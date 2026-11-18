class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :edit, :update, :destroy,:checkout]

  def show
    @cart_items = @cart.cart_items.includes(product_variant: :product)
  end
  
  def edit
  end

  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: "cart updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @cart.destroy
    redirect_to products_path, notice: "cart deleted successfullyy"
  end

  def checkout 
    @cart_items = @cart.cart_items.includes(product_variant: :product)
    @total_amount = @cart_items.sum{|item| item.price * item.qty}
  end

  private 

  def set_cart
    @cart = current_user.cart
    redirect_to products_path, alert: "cart not found" unless @cart
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
