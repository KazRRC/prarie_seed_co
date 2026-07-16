class HomeController < ApplicationController

  def index
    @categories = Category.limit(3)
    @products = Product.limit(6)
  end

end