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
  province = current_customer.province

  cart_items = session[:cart].map do |product_id, quantity|
    product = Product.find(product_id)

    price = product.on_sale? ? product.sale_price : product.price

    {
      product: product,
      quantity: quantity,
      price: price
    }
  end

  session = Stripe::Checkout::Session.create(
    mode: "payment",

    customer_email: current_customer.email,

    success_url: success_checkout_url + "?session_id={CHECKOUT_SESSION_ID}",

    cancel_url: checkout_url,

    line_items: cart_items.map do |item|
      {
        quantity: item[:quantity],

        price_data: {
          currency: "cad",

          product_data: {
            name: item[:product].name
          },

          unit_amount: (item[:price] * 100).to_i
        }
      }
    end
  )

  redirect_to session.url,
              allow_other_host: true
end
def success
end
end