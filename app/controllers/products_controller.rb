class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category)

    if params[:search].present?
      @products = @products.joins(:category)
                           .where(
                             "LOWER(products.name) LIKE LOWER(?) OR LOWER(categories.name) LIKE LOWER(?)",
                             "%#{params[:search]}%",
                             "%#{params[:search]}%"
                           )
    end

    @products = @products.order(:name)
                         .page(params[:page])
                         .per(9)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new_products
    @products = Product.new_products
                       .page(params[:page])
                       .per(9)

    render :index
  end

  def sale
    @products = Product.on_sale
                       .page(params[:page])
                       .per(9)

    render :index
  end
end