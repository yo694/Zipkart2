class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_vendor, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_user.vendor
      @products = Product.by_vendor(current_user.vendor.id)
    else
      @products = Product.all
    end
  end

  def show
  end

  def new
    @product = Product.new
    @product.product_variants.build
  end

  def create
    @product = current_user.vendor.products.build(product_params)

    if @product.save
      redirect_to @product, notice: "Product created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product deleted successfully"
  end

  private

  def set_product
    if current_user.vendor
      @product = current_user.vendor.products.find(params[:id])
    else
      @product = Product.find(params[:id])
    end
  end

  def require_vendor
    redirect_to products_path, alert: "Only vendors can manage products" unless current_user.vendor
  end

  def product_params
    params.require(:product).permit(
      :product_name,
      :description,
      product_variants_attributes: [
        :id,
        :colour,
        :size,
        :model,
        :price,
        :total_qty,
        :available_qty,
        :_destroy
      ]
    )
  end
end
