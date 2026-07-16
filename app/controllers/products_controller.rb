class ProductsController < ApplicationController

  def index
    @products = Product.includes(:category)
  end

  def show
    @product = Product.find(params[:id])
  end
def index
  @products = Product.order(:name).page(params[:page]).per(9)
end
end