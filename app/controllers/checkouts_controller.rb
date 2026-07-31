class CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def show
    if session[:cart].blank?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    unless current_customer.province
      redirect_to edit_customer_registration_path,
                  alert: "Please complete your address first."
      return
    end

    @province = current_customer.province

    @cart_items = session[:cart].map do |product_id, quantity|
      product = Product.find(product_id)

      price = product.on_sale? ? product.sale_price : product.price

      {
        product: product,
        quantity: quantity,
        price: price,
        total: price * quantity
      }
    end

    @subtotal = @cart_items.sum { |item| item[:total] }

    @gst = @subtotal * @province.gst_rate / 100
    @pst = @subtotal * @province.pst_rate / 100
    @hst = @subtotal * @province.hst_rate / 100

    @grand_total = @subtotal + @gst + @pst + @hst
  end

  def create
    # Stripe code will go here next.
  end
end