
class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :prepare_cart_item, only: [:create]
  before_action :authorize_resource

  def create
    if @cart_item.save
      redirect_to @cart, notice: "Product added to cart successfully!"
    else
      redirect_to @cart, alert: "Unable to add product to cart."
    end
  end

  private

  def prepare_cart_item
    @cart = current_user.cart || current_user.create_cart

    @product_variant = ProductVariant.find(params[:product_variant_id])

    @cart_item = @cart.cart_items.build(
      product_variant: @product_variant,
      qty: 1,
      price: @product_variant.price
    )
  end

  def authorization_resource
    @cart_item
  end
end
