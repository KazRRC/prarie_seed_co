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
  if session[:cart].blank?
    redirect_to cart_path, alert: "Your cart is empty."
    return
  end

  province = current_customer.province

  order = current_customer.orders.create!(
    status: :pending,
    total: 0,

    first_name: current_customer.first_name,
    last_name: current_customer.last_name,
    phone_number: current_customer.phone_number,
    street_address: current_customer.street_address,
    city: current_customer.city,
    province: province.name,
    postal_code: current_customer.postal_code,
    country: current_customer.country,

    gst_rate: province.gst_rate,
    pst_rate: province.pst_rate,
    hst_rate: province.hst_rate
  )

  subtotal = 0

  cart_items = session[:cart].map do |product_id, quantity|
    product = Product.find(product_id)

    price = product.on_sale? ? product.sale_price : product.price

    order.order_items.create!(
      product: product,
      quantity: quantity,
      price: price
    )

    subtotal += price * quantity

    {
      product: product,
      quantity: quantity,
      price: price
    }
  end

  gst = subtotal * province.gst_rate / 100
  pst = subtotal * province.pst_rate / 100
  hst = subtotal * province.hst_rate / 100

  total = subtotal + gst + pst + hst

  order.update!(
    subtotal: subtotal,
    gst_amount: gst,
    pst_amount: pst,
    hst_amount: hst,
    total: total
  )

  stripe_session = Stripe::Checkout::Session.create(
    mode: "payment",

    customer_email: current_customer.email,

    success_url: success_checkout_url + "?session_id={CHECKOUT_SESSION_ID}",

    cancel_url: cancel_checkout_url,

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

  order.update!(
    stripe_session_id: stripe_session.id
  )

  redirect_to stripe_session.url,
              allow_other_host: true
end
def success


  checkout_session =
    Stripe::Checkout::Session.retrieve(params[:session_id])


  @order = Order.find_by!(
    stripe_session_id: checkout_session.id
  )


  @order.update!(
    status: :paid,
    paid_at: Time.current,
    stripe_payment_intent: checkout_session.payment_intent,
    payment_id: checkout_session.payment_intent
  )


  session[:cart] = {}


end
end