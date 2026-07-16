class ProductsController < ApplicationController

def index
  @products = Product.includes(:category)

  if params[:search].present?
    @products = @products.joins(:category)
                         .where(
                           "products.name ILIKE ? OR categories.name ILIKE ?",
                           "%#{params[:search]}%",
                           "%#{params[:search]}%"
                         )
  end

  @products = @products.order(:name)
                       .page(params[:page])
                       .per(9)
end
def new
  @products = Product.new_products
                     .page(params[:page])
                     .per(9)
end
def sale
  @products = Product.on_sale
                     .page(params[:page])
                     .per(9)
end
end