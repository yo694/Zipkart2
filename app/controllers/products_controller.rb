class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    authorize Product, :index?
    @products = policy_scope(Product)
  end

  def show
    authorize @product
  end

  def new
    @product = Product.new
    @product.product_variants.build

    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    @product.vendor = current_user.vendor

    if @product.save
      redirect_to @product, notice: "Product created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @product

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