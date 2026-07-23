class CartsController < ApplicationController
  def show
    @cart_items = session[:cart].map do |product_id, quantity|
      product = Product.find(product_id)

      {
        product: product,
        quantity: quantity
      }
    end
  end

  def add
    product_id = params[:product_id].to_s

    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1

    redirect_back fallback_location: products_path,
                  notice: "Product added to cart."
  end

  def update
    product_id = params[:product_id].to_s

    session[:cart][product_id] = params[:quantity].to_i

    session[:cart].delete(product_id) if session[:cart][product_id] <= 0

    redirect_to cart_path
  end

  def remove
    session[:cart].delete(params[:product_id].to_s)

    redirect_to cart_path,
                notice: "Product removed."
  end
end