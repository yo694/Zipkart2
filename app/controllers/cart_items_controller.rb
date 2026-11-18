class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create 
    @cart = current_user.cart || current_user.create_cart
    @product_variant = ProductVariant.find(params[:product_variant_id])
    @cart.cart_items.create(
      product_variant: @product_variant,
      qty: 1,
      price: @product_variant.price
    )
    redirect_to @cart, notice: "Product added to cart successfully!"
  end
end
