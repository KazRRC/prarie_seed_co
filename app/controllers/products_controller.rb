class ProductsController < ApplicationController

  def index
    @products = Product.includes(:category)

    if params[:search].present?
      search_term = "%#{params[:search]}%"

      @products = Product.joins(:category)
                         .where(
                           "LOWER(products.name) LIKE LOWER(?) OR LOWER(categories.name) LIKE LOWER(?)",
                           search_term,
                           search_term
                         )
    end

    @products = @products.order(:name)
                         .page(params[:page])
                         .per(9)
  end


  def recent
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