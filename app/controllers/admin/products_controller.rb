class Admin::ProductsController < ApplicationController
  layout "admin"

  before_action :authenticate_customer!
  before_action :require_admin
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.includes(:category)

    if params[:search].present?
      @products = @products.where(
        "LOWER(name) LIKE LOWER(?)",
        "%#{params[:search]}%"
      )
    end

    @products = @products.order(:name)
                         .page(params[:page])
                         .per(15)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "Product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Product deleted successfully."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :stock_quantity,
      :category_id,
      :on_sale,
      :sale_price,
      :image,
      :planting_depth,
      :row_spacing,
      :plant_spacing,
      :sun_requirements,
      :days_to_germination,
      :featured
    )
  end
end