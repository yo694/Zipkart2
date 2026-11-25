class ProductsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :prepare_product, only: [:new, :create]
  before_action :authorize_resource

  def index
    
    @products = policy_scope(Product)
    if params[:search].present?
      search = params[:search].strip
      search = "%#{Product.sanitize_sql_like(params[:search])}%"
      @products = @products.where("product_name LIKE ?", search)
   end

    @products = @products.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @product.product_variants.build
  end

  def create
    @product.assign_attributes(product_params)
    @product.vendor = current_user.vendor

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

  def prepare_product
    @product = Product.new
  end

  def authorization_resource
    if action_name == "index"
      Product
    else
      @product
    end
  end

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
